class Invalid < StandardError
end

# Retrieves the max word length mapped to a particular script.
def max_word_length(script)
  max_length = 0
  script.words.each do |word|
    word_length = word.entry.length
    max_length = word_length if max_length < word_length
  end
  max_length
end

# Returns a language record given a name
def lang_by_name(name)
  lang = Language.where(name: name).first
  raise Invalid, "No language with #{name} found!" if lang.nil?
  lang
end

require 'pg'

def transfer_words
  conn = PG.connect( dbname: 'skrol_basic' )
  english = lang_by_name('English')
  conn.exec("SELECT * FROM words").each do |word|
    next if word['language'] != 'en'
    next if english.words.where(entry: word['base']).count > 0
    new_word = english.base_script.words.create(entry: word['base'])
    new_word.create_phonetic(word['phonetic'])
  end
end

def transfer_italian_words
  conn = PG.connect( dbname: 'skrol_basic' )
  italian = lang_by_name('Italian')
  conn.exec("SELECT * FROM words").each do |word|
    next if word['language'] != 'it'
    next if italian.words.where(entry: word['base']).count > 0
    en_equiv = nil
    if word['en_equiv'] != nil
      en_word = Word.where(entry: word['en_equiv']).first
      en_equiv = en_word.id unless en_word.nil?
    end

    new_word = italian.base_script.words.create(entry: word['base'], group_id: en_equiv)
    new_phonetic = new_word.create_phonetic(word['phonetic'])
    new_phonetic.group_id = en_equiv
  end
end

def parse_spanish_words
  base_word = nil
  phonetic_word = nil
  spanish = lang_by_name('Spanish')

  File.open("es_dbnary_lemon.ttl").each do |line|
    if line.match(/lexinfo:pronunciation/)
      if line.match(/@es-s-ipa/)
        phonetic_word = line.scan(/(?<=,")(.*?)(?="@es-s-ipa)/).first
      end
      if line.match(/@es-ipa/)
        if line.match(/\[/)
          phonetic_word = line.scan(/(?<=\[)(.*?)(?=\])/).first
        else
          phonetic_word = line.scan(/(?<=")(.*?)(?="@es-ipa)/).first
        end
      end
      next if phonetic_word.nil?
      base_word = base_word.first.gsub(%r{(')}, "''")
      phonetic_word = phonetic_word.first.gsub(%r{(\/|\s|\[|\])}, '').gsub(%r{(')}, "''")
      next if phonetic_word.length > 80

      new_base = spanish.base_script.words.create(entry: base_word)
      new_base.create_phonetic(phonetic_word)
      #puts base_word, phonetic_word
      base_word = phonetic_word = nil
    end
    if line.match(/lemon:writtenRep/)
      base_word = line.scan(/(?<=")(.*?)(?=")/).first
    end
  end



def translate_all_sentences(base, target)
  Sentence.where('language' => base).each do |sentence|
    translated = sentence['base'].translate(base, target)
    Sentence.create('base' => translated, 'language' => target,
                    'en_equiv' => sentence['id'])
  end
end

def derive_all_phonetics
  Sentence.all.each do |sentence|
    phonetic = sentence['base'].translate(sentence['language'], 'ipa')
    Sentence.where('id' => sentence['id']).update('phonetic' => phonetic)
  end
end

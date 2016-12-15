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

class Invalid < StandardError
end

# Takes a script record and return a catalogue object with all the characters
# used in the word records of that script along with its corresponding count.
def derive_chars_catalogue(script)
  catalogue = {}
  Word.where(script_id: script.id).each do |word|
    add_chars_to_catalogue(word, catalogue)
  end
  catalogue
end

# Adds chars to catalogue object, increments existing entry by 1 if already
# present.
def add_chars_to_catalogue(word, catalogue)
  char_arr = word.entry.scan(/./)
  char_arr.each do |char|
    if catalogue[char].nil?
      catalogue[char] = 1
    else
      catalogue[char] += 1
    end
  end
end

# Takes a script record and return a catalogue object with all the words
# used in the sentence records of that script along with its corresponding count
def derive_words_catalogue(script)
  catalogue = {}
  Sentence.where(script_id: script.id).each do |sentence|
    add_words_to_catalogue(sentence, catalogue)
  end
  catalogue
end

# Adds chars to catalogue object, increments existing entry by 1 if already
# present.
def add_words_to_catalogue(sentence, catalogue)
  word_arr = sentence.entry.gsub(/(\.|\!|\?)/, '').split
  word_arr.each do |word|
    if catalogue[word.downcase].nil?
      catalogue[word.downcase] = 1
    else
      catalogue[word] += 1
    end
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

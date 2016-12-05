class Invalid < StandardError
end

def derive_chars_catalogue(lang, script)
  catalogue = {}
  Word.where(language: lang).each do |word|
    add_chars_to_catalogue(word, script, catalogue)
  end
  catalogue
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

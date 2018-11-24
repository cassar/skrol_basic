# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Languages
languages = []
3.times { |i| languages << Language.create(name: "language#{i}") }

# Create base Scripts and LanguageMaps
standard_scripts = []
languages.each_index do |i|
  standard_scripts << languages[i].scripts.create(name: "base script#{i}")
  languages.each_index do |j|
    next if languages[i] == languages[j]
    LanguageMap.create(base_language: languages[i], target_language: languages[j])
  end
end

# Create phonetic Scripts
phonetic_scripts = []
standard_scripts.each_index do |i|
  phonetic_scripts << languages[i].scripts.create(name: "phon script#{i}",
                                                  standard_id: standard_scripts[i].id)
end

# Create Word Strings
word_strings = []
5.times { |i| word_strings << "word#{i}" }

# Create Words, Sentences, WordPhonetics, SentencesWords
standard_scripts.each_index do |i|
  word_strings.each do |string|
    std_word = standard_scripts[i].words.create(entry: string)
    phn_word = phonetic_scripts[i].words.create(entry: string)
    std_word.phonetics << phn_word
  end
  5.times do
    standard_scripts[i].sentences.create(entry: word_strings[0,3].join(' ') )
    word_strings << word_strings.shift
  end
  SentenceWordUpdater.new(standard_scripts[i]).update_all
end

# Create WordAssociates and SentenceAssociates
standard_scripts.each_index do |i|
  standard_scripts.each_index do |j|
    next if standard_scripts[i] == standard_scripts[j]
    standard_scripts[i].sentences.each_with_index do |sentence, k|
      sentence.associate_bs << standard_scripts[j].sentences[k]
    end
    standard_scripts[i].words.each_with_index do |word, k|
      word.associate_bs << standard_scripts[j].words[k]
    end
  end
end

LanguageMap.all.each { |lm| CourseCreator.create(lm) }

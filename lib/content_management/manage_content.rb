# Creates two new word records, one for the base and one for the phonetic
# versions of a word. A group_id will also be set if supplied.
def create_word(base_entry, phonetic_entry, base_script, group_id = nil)
  ActiveRecord::Base.transaction do
    base_word = base_script.words.create(entry: base_entry, group_id: group_id)
    base_word.create_phonetic(phonetic_entry)
  end
end

# Creates two new sentence records, one for the base and one for the phonetic
# versions of a word. Will throw an error if the base_entry cannot be translated
# to phonetic and will save neither entry.
def create_sentence(base_entry, base_script, group_id = nil)
  ActiveRecord::Base.transaction do
    base = base_script.sentences.create(entry: base_entry, group_id: group_id)
    base.create_phonetic
  end
end

# Returns an array containing all sentences whose entries contain the given
# word record's entry.
def sentences_found_in(word)
  sentences = []
  word.script.sentences.each do |sentence|
    sentences << sentence if word_in_sentence?(word, sentence)
  end
  sentences
end

# Returns true if a word is reperesented in a sentence, false otherwise.
def word_in_sentence?(word, sentence)
  candidate = nil
  return true if sentence.entry.include? word.entry
  return true if sentence.entry.include? word.entry.capitalize
  false
end

# Outs language stats to the console
def language_stats(language)
  basic_lang_metrics(language)
  lang_histogram(language)
end

# Puts basic metrics out to the terminal
def basic_lang_metrics(language)
  puts "Basic metrics for language: #{language.name}"
  puts "Total Characters: #{language.characters.count}"
  puts "Total Words: #{language.words.count}"
  puts "Total Sentences: #{language.sentences.count}"
end

# Returns a histogram of a given language record, specifically...
#   The minimum number of representations that a word has across all sentences.
#   (and the entry)
#   The maximum number of representations that a word has across all sentences.
#   (and the entry)
#   The average number of representations for each word across all sentences.
def lang_histogram(language)
  word_rep_counts = return_word_rep_counts(language)
  average = compute_average_reps(word_rep_counts)
  puts_histogram(word_rep_counts, average)
end

def puts_histogram(word_rep_counts, average)
  min = word_rep_counts.values.min
  max = word_rep_counts.values.max
  puts "Min representations: #{min}"
  puts "Max representations: #{max}"
  puts "Average representations: #{average}"
end

def return_word_rep_counts(language)
  word_rep_counts = {}
  language.base_script.words.each do |word|
    word_rep_counts[word.id] = sentences_found_in(word).count
  end
  word_rep_counts
end

def compute_average_reps(word_rep_counts)
  total_reps = 0
  word_rep_counts.each { |_key, value| total_reps += value }
  total_reps.to_f / word_rep_counts.count
end

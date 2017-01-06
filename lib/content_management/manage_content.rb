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

# Will report how many words are above the given hurdle of sentences represented
# in and will suggest the next word to add sentences to raise it above the
# hurdle based on the WTS.
def content_add_helper(base_script, target_script, hurdle)
  word_rep_counts = return_word_rep_counts(target_script)
  total_reached = return_total_reached(word_rep_counts, hurdle)
  next_word = next_word_below_hurdle(word_rep_counts, hurdle, base_script)
  raise Invalid, 'No next_word found!' if next_word.nil?
  count = word_rep_counts[next_word.id]
  puts "#{total_reached} word records at #{hurdle} reps or more."
  puts "Add sentences for word_entry: #{next_word.entry} (#{count} reps)"
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
def lang_histogram(base_script)
  word_rep_counts = return_word_rep_counts(base_script)
  average = compute_average_reps(word_rep_counts)
  puts_histogram(word_rep_counts, average)
end

# Outsputs the minimum and maximum number of representations for a collection
# of word records and also the average.
def puts_histogram(word_rep_counts, average)
  min = word_rep_counts.values.min
  max = word_rep_counts.values.max
  puts "Min representations: #{min}"
  puts "Max representations: #{max}"
  puts "Average representations: #{average}"
end

# Returns catalogue of key value pairs where the key is the target word and the
# value is the number sentence representations that word record has.
def return_word_rep_counts(base_script)
  word_rep_counts = {}
  base_script.words.each do |word|
    word_rep_counts[word.id] = sentences_found_in(word).count
  end
  word_rep_counts
end

# returns the average number of representations that all words have across all
# sentences.
def compute_average_reps(word_rep_counts)
  total_reps = 0
  word_rep_counts.each { |_key, value| total_reps += value }
  total_reps.to_f / word_rep_counts.count
end

# Returns the total number of word records that have reached the given hurdle.
def return_total_reached(word_rep_counts, hurdle)
  total_reached = 0
  word_rep_counts.each { |_key, value| total_reached += 1 if value >= hurdle }
  total_reached
end

# Returns the next word record whose number of representations is under a given
# hurdle and mapped to a base_language
def next_word_below_hurdle(word_rep_counts, hurdle, base_script)
  next_score = template = { entry: -1 }
  word_rep_counts.each do |key, value|
    next if value >= hurdle
    candidate = retrieve_wts(key, base_script)
    next_score = candidate if candidate.entry > next_score[:entry]
  end
  return nil if next_score == template
  word_by_id(next_score.entriable_id)
end

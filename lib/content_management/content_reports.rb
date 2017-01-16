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

def puts_sentence_groups
  english = lang_by_name('English').base_script
  english.sentences.each do |sentence|
    Sentence.where(group_id: sentence.group_id).each { |sent| puts sent.entry }
  end
end

# Loops through all sentences and identifies any words in the sentence that are
# not in the words table.
def missing_words_report(script)
  entries = []
  script.sentences.each do |sentence|
    sentence.entry.split_sentence.each do |entry|
      entries << entry unless word_present?(entry, script)
    end
  end
  entries.uniq.each do |entry|
    word = script.words.create(entry: entry)
    word.create_phonetic('[new]')
  end
end

# Returns true if a word entry is present in the words db false other wise.
def word_present?(entry, script)
  return true if script.words.where(entry: entry).first.present?
  return true if script.words.where(entry: entry.downcase).first.present?
  return true if script.words.where(entry: entry.capitalize).first.present?
  false
end

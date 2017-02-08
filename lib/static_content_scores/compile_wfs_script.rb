# Calculates and stores all the Word Frequency Score (WFS) for a particular
# script.
def compile_wfs_script(script)
  raise Invalid, 'No words attached to script!' if script.words.count < 1
  catalogue = derive_words_catalogue(script)
  total_words = return_word_total(catalogue)
  assign_wfs(script, catalogue, total_words)
end

# Takes a script record and return a catalogue object with all the words
# used in the sentence records of that script along with its corresponding count
def derive_words_catalogue(script)
  catalogue = {}
  script.sentences.each do |sentence|
    # Sentence.where(script_id: script.id).each do |sentence|
    add_words_to_catalogue(sentence, catalogue)
  end
  catalogue
end

# Adds chars to catalogue object, increments existing entry by 1 if already
# present.
def add_words_to_catalogue(sentence, catalogue)
  entry_arr = sentence.entry.split_sentence
  entry_arr.each do |entry|
    entry_down = entry.downcase
    if catalogue[entry_down].nil?
      catalogue[entry_down] = 1
    else
      catalogue[entry_down] += 1 unless catalogue[entry_down].nil?
    end
  end
end

# Returns the total of all values in an object called catalogue
def return_word_total(catalogue)
  total = 0
  catalogue.each do |_key, value|
    total += value
  end
  total
end

# Creates new WFS score record for all matching word records belonging to a
# script
def assign_wfs(script, catalogue, total_words)
  script.words.each do |word|
    numerator = catalogue[word.entry]
    numerator = 0 if numerator.nil?
    score = numerator.to_f / total_words
    word.create_update_score('WFS', script, score)
  end
end

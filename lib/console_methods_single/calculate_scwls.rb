# Calculates the Sentence Constituent Word Lengths Score (SCWLS) for a
# particular sentence.
def calculate_scwls(sentence)
  total_scores = 0
  sentence_arr = sentence.entry.gsub(/(\.|\!|\?)/, '').split
  script = sentence.script
  sentence_arr.each do |entry|
    total_scores += retrieve_wls_score(entry, script)
  end
  total_scores / sentence_arr.length
end

# Retrieves the WLS score for a word record given an entry and script.
def retrieve_wls_score(word_entry, script)
  word = script.words.where(entry: word_entry).first
  word = script.words.where(entry: word_entry.downcase).first if word.nil?
  return 0.0 if word.nil?
  word.scores.where(name: 'WLS').first.entry
end

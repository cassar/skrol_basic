# Calculates the Sentence Word Frequency Score (SWFS) for a particular sentence.
def calculate_swfs(sentence)
  wfs_scores = 0
  sentence_arr = sentence.entry.gsub(/(\.|\!|\?)/, '').split
  script = sentence.script
  sentence_arr.each do |entry|
    wfs_scores += retrieve_wfs_score(entry, script)
  end
  wfs_scores / sentence_arr.length
end

# Retrieves the wfs score for a word record given an entry and script.
def retrieve_wfs_score(word_entry, script)
  word = script.words.where(entry: word_entry).first
  word = script.words.where(entry: word_entry.downcase).first if word.nil?
  return 0.0 if word.nil?
  word.scores.where(name: 'WFS').first.entry
end

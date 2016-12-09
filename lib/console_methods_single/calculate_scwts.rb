# Calculates the Sentence Constituent Word Total Score (SCWTS) for a
# particular sentence.
def calculate_scwts(target_sentence, base_script)
  total_scores = 0
  sentence_arr = target_sentence.entry.gsub(/(\.|\!|\?)/, '').split
  target_script = target_sentence.script
  sentence_arr.each do |entry|
    total_scores += retrieve_wts_score(entry, target_script, base_script)
  end
  total_scores / sentence_arr.length
end

# Retrieves the WTS score for a word record given an entry and script.
def retrieve_wts_score(target_entry, target_script, base_script)
  target_word = target_script.words.where(entry: target_entry).first
  if target_word.nil?
    target_word = target_script.words.where(entry: target_entry.downcase).first
  end
  return 0.0 if target_word.nil?
  calculate_wts(target_word, base_script)
end

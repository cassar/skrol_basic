# Compiles all SCWTS for all sentences attached to a given target script mapped
# to a given base script.
def compile_scwts(target_script, base_script)
  target_script.sentences.each do |target_sentence|
    score_entry = calculate_scwts(target_sentence, base_script)
    target_sentence.create_update_sts('SCWTS', base_script, score_entry)
  end
end

# Calculates the Sentence Constituent Word Total Score (SCWTS) for a
# particular sentence.
def calculate_scwts(target_sentence, base_script)
  total_scores = 0
  sentence_arr = target_sentence.entry.split_sentence
  target_script = target_sentence.script
  sentence_arr.each do |entry|
    total_scores += retrieve_wts_score(entry, target_script, base_script)
  end
  total_scores / sentence_arr.length
end

# Retrieves the WTS score for a word record given an entry and script.
def retrieve_wts_score(target_entry, target_script, base_script)
  target_word = target_script.words.where(entry: target_entry).first
  return 0.0 if target_word.nil?
  target_word.retrieve_score('WTS', base_script).entry
end

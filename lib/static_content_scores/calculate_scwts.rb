# Compiles all SCWTS for all sentences attached to a given target script mapped
# to a given base script.
def compile_scwts(lang_map)
  lang_map.target_script.sentences.each do |target_sentence|
    score_entry = calculate_scwts(target_sentence, lang_map)
    target_sentence.create_update_sts('SCWTS', lang_map, score_entry)
  end
end

# Calculates the Sentence Constituent Word Total Score (SCWTS) for a
# given a lang_map.
def calculate_scwts(target_sentence, lang_map)
  total_scores = 0
  sentence_arr = target_sentence.entry.split_sentence
  target_script = target_sentence.script
  sentence_arr.each do |entry|
    total_scores += retrieve_wts_score(entry, lang_map)
  end
  total_scores / sentence_arr.length
end

# Retrieves the WTS score for a word record given an entry and a lang_map.
def retrieve_wts_score(target_entry, lang_map)
  target_word = lang_map.target_script.words.find_by entry: target_entry
  return 0.0 if target_word.nil?
  target_word.retrieve_score('WTS', lang_map).entry
end

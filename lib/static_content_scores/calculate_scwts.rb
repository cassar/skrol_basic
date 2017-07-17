# Calculates the Sentence Constituent Word Total Score (SCWTS) for a
# given a lang_map.
def calculate_scwts(target_sentence, wts_entry_obj)
  total_scores = 0
  sentence_arr = target_sentence.entry.split_sentence
  sentence_arr.each do |entry|
    total_scores += retrieve_wts_score(entry, wts_entry_obj)
  end
  total_scores / sentence_arr.length
end

# Retrieves the WTS score for a word record given an entry and a lang_map.
def retrieve_wts_score(target_entry, wts_entry_obj)
  target_word = wts_entry_obj[target_entry]
  return 0.0 if target_word.nil?
  # target_word.retrieve_score('WTS', lang_map).entry
  target_word
end

# Calculates and creates new WCFBS score given a target_word record and a
# base_script
def compile_wcfbs(target_word, base_script, word_scores_obj, all_char_scores)
  score = calculate_wcfbs(target_word, base_script, all_char_scores)
  word_scores_obj[target_word.id]['WCFBS'] = score
end

# Calculates the Word Characters Frequency Target Scores (WCFBS) for a
# particular entry.
def calculate_wcfbs(target_word, base_script, all_char_scores)
  scores_sum = 0.0
  return scores_sum if target_word.nil?
  char_arr = target_word.entry.scan(/./)
  char_arr.each do |entry|
    scores_sum += return_cfils_score(entry, base_script, all_char_scores)
  end
  scores_sum / target_word.entry.length
end

# Retrieves a CFILS score for a particular char entry and script mapped to a
# particular base_script.
# This is the CFS of the charcter in a target script.
def return_cfils_score(char_entry, base_script, all_char_scores)
  score = all_char_scores[base_script.id][char_entry]
  return 0.0 if score.nil?
  score
end

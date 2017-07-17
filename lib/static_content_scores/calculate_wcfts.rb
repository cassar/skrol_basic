# Calculates and creates a new WCFTS score for a given word record.
def compile_wcfts(target_word, word_scores_obj, all_char_scores)
  score = calculate_wcfts(target_word, all_char_scores)
  word_scores_obj[target_word.id]['WCFTS'] = score
end

# Calculates the Word Characters Frequency Base Scores (WCFTS) for a
# particular word record.
def calculate_wcfts(target_word, all_char_scores)
  scores_sum = 0.0
  return scores_sum if target_word.nil?
  char_arr = target_word.entry.scan(/./)
  target_script = target_word.script
  char_arr.each { |entry| scores_sum += all_char_scores[target_script.id][entry] }
  score = scores_sum / target_word.entry.length
end

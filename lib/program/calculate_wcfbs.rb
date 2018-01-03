# Compiles a Word Character Frequency Base Score (WCFBS) for each target word
# in an array of target words and adds that score with its respective WCFBS
# weight (WCFBSW) to that target word's record in that wts_scores_obj
def compile_wcfbs_script(standard_words, wts_scores_obj)
  target_words, base_words = standard_words
  bse_char_scrs = compile_chars_cfs(base_words)
  target_words.each do |target_word|
    score = calculate_wcfbs(target_word, bse_char_scrs)
    wts_scores_obj[target_word.id] += score * WCFBSW
  end
end

# Calculates the Word Characters Frequency Target Scores (WCFBS) for a
# particular entry.
def calculate_wcfbs(target_word, bse_char_scrs)
  scores_sum = 0.0
  return scores_sum if target_word.nil?
  char_arr = target_word.entry.scan(/./)
  char_arr.each { |entry| scores_sum += cfils_score(entry, bse_char_scrs) }
  scores_sum / target_word.entry.length
end

# Returns a CFILS score for a particular char entry.
def cfils_score(char_entry, bse_char_scrs)
  score = bse_char_scrs[char_entry]
  return 0.0 if score.nil?
  score
end

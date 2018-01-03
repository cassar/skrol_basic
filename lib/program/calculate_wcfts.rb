# Calculates the Word Character Frequency Target Score (WCFTS) for a
# group of target_words and updates the wts_scores_obj to include this score
def compile_wcfts_script(target_words, wts_scores_obj)
  tar_char_scrs = compile_chars_cfs(target_words)
  target_words.each do |target_word|
    score = calculate_wcfts(target_word, tar_char_scrs)
    wts_scores_obj[target_word.id] += score * WCFTSW
  end
end

# Calculates the Word Characters Frequency Base Scores (WCFTS) for a
# particular word record.
def calculate_wcfts(target_word, tar_char_scrs)
  scores_sum = 0.0
  return scores_sum if target_word.nil?
  char_arr = target_word.entry.scan(/./)
  char_arr.each { |entry| scores_sum += tar_char_scrs[entry] }
  scores_sum / target_word.entry.length
end

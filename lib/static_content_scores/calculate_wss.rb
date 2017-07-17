# Calculates the Word Similarity Scores (WSS) for a particular word record
# to a target_word record and saves the record as a new score.
def compile_wss(target_word, word_scores_obj, base_entries)
  base_entry = base_entries[target_word.group_id]
  if base_entry.nil?
    word_scores_obj[target_word.id]['WSS'] = 0.0
    return
  end
  score = calculate_wss(target_word, base_entry)
  word_scores_obj[target_word.id]['WSS'] = score
end

# Calculates the Word Similarity Scores (WSS) for a particular word record
# to a target_word record
def calculate_wss(target_word, base_entry)
  base_char_arr = base_entry.scan(/./)
  target_char_arr = target_word.entry.scan(/./)
  return_score(base_char_arr, target_char_arr)
end

# Returns wss score between two word arrays.
def return_score(base_char_arr, target_char_arr)
  candidate_arr = []
  base_counter = 0
  base_char_arr.each do |base_char|
    candidate_arr << return_base_candidate(base_char, base_counter,
                                           target_char_arr)
    base_counter += 1
  end
  score_array = compile_score_array(candidate_arr)
  compile_wss_score(score_array, base_char_arr, target_char_arr)
end

# Returns array of absolute positions away from base_char of every target_char
# if there is a comparison to be made.
def return_base_candidate(base_char, base_counter, target_char_arr)
  base_candidate = []
  target_counter = 0
  target_char_arr.each do |target_char|
    verdict = base_char == target_char
    base_candidate << (base_counter - target_counter).abs if verdict
    target_counter += 1
  end
  base_candidate
end

# Returns the score_array for a given candidate_arr, the score array contains
# all the char position scores greater than 0.
def compile_score_array(candidate_arr)
  score_array = []
  candidate_arr.each do |candidate|
    next if candidate.empty?
    minimum = candidate.min
    score_array << 1.0 / (minimum + 1)
  end
  score_array
end

# Returns the WSS score of 2 words given a score_array, and two char arrays.
def compile_wss_score(score_array, base_char_arr, target_char_arr)
  numerator = score_array.sum
  denominator = (base_char_arr.length + target_char_arr.length) / 2.0
  score = numerator / denominator
end

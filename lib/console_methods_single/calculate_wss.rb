# Calculates the Word Similarity Scores (WSS) for a particular word record
# to a target_word record and saves the record as a new score.
def compile_wss(word, target_word)
  score = calculate_wss(word, target_word)
  word.scores.create(map_to_id: target_word.id, map_to_type: 'words',
                     name: 'WSS', entry: score)
end

# Calculates the Word Similarity Scores (WSS) for a particular word record
# to a target_word record
def calculate_wss(word, target_script)
  target_word = target_script.words.where(group_id: word.group_id).first
  return 0.0 if target_word.nil?
  base_char_arr = word.entry.scan(/./)
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

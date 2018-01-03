# Calculates the Word Similarity Scores (WSS) for each word in a given array
# of words, word arrays should be given in phonetic form.
def compile_wss_script(content_manager, wts_scores_obj)
  target_words, base_words = content_manager.phonetic_words
  tar_id_to_base_entry = derive_tar_id_to_base_entry(base_words, content_manager)
  target_words.each do |target_word|
    base_entry = tar_id_to_base_entry[target_word.id]
    next if base_entry.nil?
    score = calculate_wss(target_word, base_entry)
    wts_scores_obj[target_word.assoc_id] += score * WSSW
  end
end

def derive_tar_id_to_base_entry(base_words, content_manager)
  tar_stn_spt, bse_stn_spt = content_manager.standard_scripts
  base_id_to_entry = derive_record_id_to_record(base_words)
  word_associates = tar_stn_spt.word_associates(bse_stn_spt)
  tar_id_to_base_entry = {}
  word_associates.each do |word_associate|
    add_to_tar_id_to_base_entry(word_associate, base_id_to_entry, tar_id_to_base_entry)
  end
  tar_id_to_base_entry
end

def add_to_tar_id_to_base_entry(word_associate, base_id_to_entry, tar_id_to_base_entry)
  assoc_a = base_id_to_entry[a_id = word_associate.associate_a_id]
  assoc_b = base_id_to_entry[b_id = word_associate.associate_b_id]
  return unless assoc_a.present? || assoc_b.present?
  if assoc_b.present?
    tar_id_to_base_entry[a_id] = assoc_b.entry
  else
    tar_id_to_base_entry[b_id] = assoc_a.entry
  end
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

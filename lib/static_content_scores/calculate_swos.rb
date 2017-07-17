# Calculates the Sentence Word Order Score (SWOS) for a particular sentence and
# its counterpart in another script.
def calculate_swos(target_sentence, base_script, target_entry_group_obj, base_entry_group_obj)
  base_sentence = base_script.sentences.find_by group_id: target_sentence.group_id
  target_group_arr = return_group_arr(target_sentence, target_entry_group_obj)
  base_group_arr = return_group_arr(base_sentence, base_entry_group_obj)
  return_swos_score(target_group_arr, base_group_arr)
end

# Returns the SWOS score for two given word arrays.
def return_swos_score(target_group_arr, base_group_arr)
  pos_scores = target_counter = 0
  target_group_arr.each do |target_group|
    unless target_group.nil?
      candidate_arr = return_candidate_arr(base_group_arr, target_group,
                                           target_counter)
      pos_scores += 1.0 / (1 + candidate_arr.min) unless candidate_arr.empty?
    end
    target_counter += 1
  end
  pos_scores / ((target_group_arr.length + base_group_arr.length) / 2)
end

# Returns an array of absolute positions where a base_group could be.
def return_candidate_arr(base_group_arr, target_group, target_counter)
  candidate_arr = []
  base_counter = 0
  base_group_arr.each do |base_group|
    if target_group == base_group && !base_group.nil?
      candidate_arr << (target_counter - base_counter).abs
    end
    base_counter += 1
  end
  candidate_arr
end

# Returns array of word records for a given sentence record.
def return_group_arr(sentence, entry_group_obj)
  group_arr = []
  sentence.entry.split_sentence.each do |entry|
    group_arr << entry_group_obj[entry]
  end
  group_arr
end

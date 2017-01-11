# Calculates the Sentence Word Order Score (SWOS) for a particular sentence and
# its counterpart in another script.
def calculate_swos(target_sentence, base_script)
  base_sentence =
    base_script.sentences.where(group_id: target_sentence.group_id).first
  target_word_arr = return_word_arr(target_sentence)
  base_word_arr = return_word_arr(base_sentence)
  return_swos_score(target_word_arr, base_word_arr)
end

# Returns the SWOS score for two given word arrays.
def return_swos_score(target_word_arr, base_word_arr)
  pos_scores = target_counter = 0
  target_word_arr.each do |target_word|
    unless target_word.group_id.nil?
      candidate_arr = return_candidate_arr(base_word_arr, target_word,
                                           target_counter)
      pos_scores += 1.0 / (1 + candidate_arr.min) unless candidate_arr.empty?
    end
    target_counter += 1
  end
  pos_scores / ((target_word_arr.length + base_word_arr.length) / 2)
end

# Returns an array of absolute positions where a base_word could be.
def return_candidate_arr(base_word_arr, target_word, target_counter)
  candidate_arr = []
  base_counter = 0
  base_word_arr.each do |base_word|
    if target_word.group_id == base_word.group_id && !base_word.group_id.nil?
      candidate_arr << (target_counter - base_counter).abs
    end
    base_counter += 1
  end
  candidate_arr
end

# Returns array of word records for a given sentence record.
def return_word_arr(sentence)
  entry_arr = sentence.entry.split_sentence
  word_arr = []
  entry_arr.each do |entry|
    word_arr << retrieve_word(entry, sentence.script)
  end
  word_arr
end

# retrieves a word record given an entry and a script.
def retrieve_word(entry, script)
  word = script.words.where(entry: entry).first
  word = script.words.where(entry: entry.downcase).first if word.nil?
  word
end

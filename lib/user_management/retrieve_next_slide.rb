# Will retrieve an object containing...
#   representative: (a target word record that the slide is meant to test)
#   target_sentence: (a target sentence that has been chosen to test the user)
#   phonetic_sentence: (a phonetic sentence equivalent of the target_sentence)
#   base_sentence: (a base sentence equivalent of the target sentence)
#   target_arr: (an array of word records used in the target sentence)
#   phonetic_arr: (an array of word records used in the phonetic sentence)
#   base_arr: (an array of word records used in the base sentence)
def retrieve_next_slide(user_map)
  target_word, target_sentence =
    return_next_available_entries(user_map)
  # Create or update word score
  user_map.user.create_touch_score(target_word)
  # Create new Metric stub
  user_map.user.create_metric_stub(target_word, target_sentence)
  return_slide(target_word, target_sentence, user_map.base_script)
end

# Retrieves the next available sentence and word entries that a user will view.
def return_next_available_entries(user_map)
  loop do
    # Search for target_word
    target_word = retrieve_next_word(user_map)
    raise Invalid, 'no more words!' if target_word.nil?
    # Search for matching target_sentence
    target_sentence = retrieve_next_sentence(target_word, user_map)
    # Break if one found
    return [target_word, target_sentence] if target_sentence.present?
    # Push user word score up to THRESHOLD so next word will be retrieved.
    user_map.user.raise_to_threshold(target_word)
  end
end

# Retrieves the next word a user will view given user and target_script record
def retrieve_next_word(user_map)
  word = word_from_scores(user_map.user, user_map.target_script)
  word = word_from_words(user_map) if word.nil?
  word
end

# Retrieves the next sentence a user will view given a word object
def retrieve_next_sentence(target_word, user_map)
  max_score = template = { entry: -1 }
  target_word.reps.each do |sentence_id|
    next if sentence_used?(sentence_id, user_map.user)
    score = retrieve_sts(sentence_id, user_map.lang_map)
    max_score = score if score.entry > max_score[:entry]
  end
  return nil if max_score == template
  sentence_by_id(max_score.entriable_id)
end

# Returs slide object given a target_word, target_sentence, and user records
def return_slide(target_word, target_sentence, base_script)
  slide = {}
  slide[:representative] = target_word
  assign_sentences(slide, target_sentence, base_script)
  assign_arrays(slide, target_sentence)
  slide
end

# assigns the sentences to the slide object given a target_sentence
def assign_sentences(slide, target_sentence, base_script)
  slide[:target_sentence] = target_sentence
  slide[:base_sentence] = target_sentence.corresponding(base_script)
  slide[:phonetic_sentence] = target_sentence.phonetic
end

# assigns the array's to the slide object given a target_sentence
def assign_arrays(slide, target_sentence)
  slide[:target_arr] = return_word_array(target_sentence)
  slide[:phonetic_arr] = phonetic_arr_from_base_arr(slide[:target_arr])
  slide[:base_arr] = return_word_array(slide[:base_sentence])
end

# returns a word record if one is suitable in the user's scores section.
def word_from_scores(user, target_script)
  max_score = template = { entry: -1 }
  user.user_scores.where(status: 'tested').each do |score|
    next if score.entry > THRESHOLD
    next if score.target_script != target_script
    max_score = score if score.entry > max_score[:entry]
  end
  return nil if max_score == template
  word_by_id(max_score.target_word_id)
end

# Retrieves the next Word record from a the Word table for a User
def word_from_words(user_map)
  rank_num = user_map.rank_num
  word = nil
  loop do
    word = word_by_rank(user_map, rank_num)
    break unless word_used?(word, user_map.user)
    rank_num += 1
  end
  user_map.update(rank_num: rank_num)
  word
end

# Returns true if a word has (already) been viewed by a user, false otherwise
def word_used?(word, user)
  score = user.user_scores.where(target_word_id: word.id).first
  return false if score.nil?
  true
end

# Returns true if a sentence has already been viewed by a user, false otherwise
def sentence_used?(sentence_id, user)
  metric = user.user_metrics.where(target_sentence_id: sentence_id).first
  return false if metric.nil?
  true
end

# Returns array of word records given a sentence record
def return_word_array(sentence)
  word_arr = []
  entry_arr = sentence.entry.split_sentence
  script = sentence.script
  entry_arr.each do |entry|
    word = return_word(entry, script)
    raise Invalid, "No word entry found for entry: #{entry}" if word.nil?
    word_arr << word
  end
  word_arr
end

# Return phonetic array of a base array
def phonetic_arr_from_base_arr(base_arr)
  word_arr = []
  base_arr.each { |word| word_arr << word.phonetic }
  word_arr
end

# Returs an STS given a sentence ID and a base script.
def retrieve_sts(sentence_id, lang_map)
  score = Score.where(entriable_id: sentence_id, entriable_type: 'Sentence',
                      name: 'STS', map_to_id: lang_map.id,
                      map_to_type: 'LangMap').first
  raise Invalid, "No STS found for sentence_id: #{sentence_id}" if score.nil?
  score
end

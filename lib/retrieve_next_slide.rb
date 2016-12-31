
# Retrieves the next slide object for use in the client.
def retrieve_next_slide(user, target_script)
  # Search for target_word
  target_word = retrieve_next_word(user, target_script)
  raise Invalid, 'no more words!' if target_word.nil?
  # Search for matching target_sentence
  target_sentence = retrieve_next_sentence(user, target_word)
  raise Invalid, 'no more sentences!' if target_sentence.nil?
  # Create or update word score
  user.create_touch_score(target_word)
  # Create new Metric stub
  user.create_metric_stub(target_word, target_sentence)
  return_slide(target_word, target_sentence, user)
end

# Retrieves the next word a user will view given user and target_script record
def retrieve_next_word(user, target_script)
  word = word_from_scores(user, target_script)
  word = word_from_words(user, target_script) if word.nil?
  word
end

# Retrieves the next sentence a user will view given a word object
def retrieve_next_sentence(user, target_word)
  max_score = template = { entry: -1 }
  target_word.script.sentences.each do |sentence|
    next if sentence_used?(sentence, user)
    next unless word_in_sentence?(target_word, sentence)
    score = sentence.retrieve_sts(user.base_script)
    max_score = score if score.entry > max_score[:entry]
  end
  return nil if max_score == template
  sentence_by_id(max_score.entriable_id)
end

# Returs slide object given a target_word, target_sentence, and user records
def return_slide(target_word, target_sentence, user)
  slide = {}
  slide[:representative] = target_word
  assign_sentences(slide, target_sentence, user)
  assign_arrays(slide, target_sentence)
  slide
end

# assigns the sentences to the slide object given a target_sentence
def assign_sentences(slide, target_sentence, user)
  slide[:target_sentence] = target_sentence
  slide[:base_sentence] = user.base_sentence(target_sentence)
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
def word_from_words(user, target_script)
  max_score = template = { entry: -1 }
  target_script.retrieve_all_wts(user.base_script).each do |score|
    word = word_by_id(score.entriable_id)
    next if word_used?(word, user)
    max_score = score if score.entry > max_score[:entry]
  end
  return nil if max_score == template
  word_by_id(max_score.entriable_id)
end

# Returns true if a word has (already) been viewed by a user, false otherwise
def word_used?(word, user)
  score = user.user_scores.where(target_word_id: word.id).first
  return false if score.nil?
  true
end

# Returns true if a sentence has already been viewed by a user, false otherwise
def sentence_used?(sentence, user)
  metric = user.user_metrics.where(target_sentence_id: sentence.id).first
  return false if metric.nil?
  true
end

# Returns true if a word is reperesented in a sentence, false otherwise.
def word_in_sentence?(word, sentence)
  candidate = nil
  return true if sentence.entry.include? word.entry
  return true if sentence.entry.include? word.entry.capitalize
  false
end

# Returns array of word records given a sentence record
def return_word_array(sentence)
  word_arr = []
  entry_arr = sentence.entry.gsub(/(\.|\!|\?)/, '').split
  entry_arr.each do |entry|
    word = return_word(sentence.script, entry)
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

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
  # Create new Metric stub
  user_map.create_metric_stub(target_word, target_sentence)
  return_html_slide(target_word, target_sentence, user_map)
end

# Retrieves the next available sentence and word entries that a user will view.
def return_next_available_entries(user_map)
  loop do
    # Search for target_word
    target_word = retrieve_next_word(user_map)
    # Search for matching target_sentence
    target_sentence = retrieve_next_sentence(target_word, user_map)
    # Break if one found
    return [target_word, target_sentence] if target_sentence.present?
    # Push user word score up to THRESHOLD so next word will be retrieved.
    user_map.raise_to_threshold(target_word)
  end
end

# Retrieves the next word a user will view given user and target_script record
def retrieve_next_word(user_map)
  word = word_from_scores(user_map, user_map.target_script)
  word = word_from_words(user_map) if word.nil?
  raise Invalid, 'no more words!' if word.nil?
  # Create or update word score
  user_map.create_touch_score(word)
  word
end

# Retrieves the next sentence a user will view given a word object
def retrieve_next_sentence(target_word, user_map)
  user_score = user_map.retrieve_user_score(target_word)
  target_word.rep_sents.each do |rep_sent|
    rank = rep_sent.retrieve_rank(user_map)
    next if rank.nil?
    if rank.entry == user_score.sentence_rank
      user_score.increment_sentence_rank
      return sentence_by_id(rep_sent.rep_sent_id)
    end
  end
  nil
end

# Determines weather a sentence is valid for presentation in the view.
def sentence_valid?(sentence_id, user_map)
  return false if sentence_used?(sentence_id, user_map)
  phonetic_entry = sentence_by_id(sentence_id).phonetic.entry
  return false if phonetic_entry.include? NONE
  return false if phonetic_entry.length > 40
  true
end

# Returns the HTML slide to be sent to the client.
def return_html_slide(target_word, target_sentence, user_map)
  content = return_div_content(target_sentence, user_map)
  group_label = "data-group=\"#{target_sentence.group_id}\""
  rep_label = "data-word=\"#{target_word.id}\""
  data_attr = group_label + ' ' + rep_label
  entry = "<div class=\"sentences\"  #{data_attr}>#{content}</div>"
  { entry: entry }
end

# Returns the base_sentence, target_sentence, phonetic_sentence in html divs.
def return_div_content(target_sentence, user_map)
  sentences = [target_sentence, target_sentence.phonetic,
               target_sentence.corresponding(user_map.base_script)]
  content = ''
  sentences.each do |sentence|
    content << '<div>' + sentence.entry + '</div>'
  end
  content
end

# returns a word record if one is suitable in the user's scores section.
def word_from_scores(user_map, target_script)
  max_score = template = { entry: -1 }
  user_map.user_scores.where(status: 'tested').each do |score|
    next if score.entry > THRESHOLD
    next if score.target_script != target_script
    max_score = score if score.entry > max_score[:entry]
  end
  return nil if max_score == template
  word_by_id(max_score.target_word_id)
end

# Retrieves the next Word record from a the Word table for a User
def word_from_words(user_map)
  word_rank = user_map.word_rank
  word = nil
  loop do
    word = word_by_rank(user_map, word_rank)
    break unless word_used?(word, user_map)
    word_rank += 1
  end
  user_map.update(word_rank: word_rank)
  word
end

# Returns true if a word has (already) been viewed by a user, false otherwise
def word_used?(word, user_map)
  score = user_map.user_scores.where(target_word_id: word.id).first
  return false if score.nil?
  true
end

# Returns true if a sentence has already been viewed by a user, false otherwise
def sentence_used?(sentence_id, user_map)
  metric = user_map.user_metrics.where(target_sentence_id: sentence_id).first
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

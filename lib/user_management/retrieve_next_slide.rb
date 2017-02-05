# Will retrieve an object containing the html representation of the slide.
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
  word = word_from_scores(user_map)
  word = word_from_words(user_map) if word.nil?
  raise Invalid, 'no more words!' if word.nil?
  # Create or update word score
  user_map.create_touch_score(word)
  word
end

# Retrieves the next sentence a user will view given a word object
def retrieve_next_sentence(target_word, user_map)
  user_score = user_map.retrieve_user_score(target_word)
  sentence = nil
  loop do
    correct_rank_found = false
    sentence =
      search_rep_sents(target_word, user_map, user_score, correct_rank_found)
    break if sentence.present? || !correct_rank_found
  end
  sentence
end

# Searches through a group of rep sents to see if a next sentence can be found
def search_rep_sents(target_word, user_map, user_score, _correct_rank_found)
  target_word.rep_sents.each do |rep_sent|
    rank = rep_sent.retrieve_rank(user_map)
    next if rank.nil?
    next unless rank.entry == user_score.sentence_rank
    correct_rank_found = true
    user_score.increment_sentence_rank
    break if sentence_used?(rep_sent.rep_sent_id, user_map)
    return sentence_by_id(rep_sent.rep_sent_id)
  end
  nil
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

def return_div_content(target_sentence, user_map)
  sentences_info = [[target_sentence], [target_sentence.phonetic],
                    [target_sentence.corresponding(user_map.base_script)]]
  add_record_entry_arrs(sentences_info)
  content = ''
  sentences_info.each do |element|
    element << element[0].entry.split
    compile_sentence_html(element, content)
  end
  content
end

def compile_sentence_html(element, content)
  html_sent = ''
  counter = 0
  element[2].each do |entry|
    group_id = element[1][counter].group_id
    html_sent <<
      "<div class=\"word\" data-group=\"#{group_id}\"> #{entry}</div>&nbsp"
    counter += 1
  end
  content << "<div class=\"sentence\">#{html_sent}</div>"
end

def add_record_entry_arrs(sentences_info)
  target_arr = return_word_array(sentences_info[0][0])
  sentences_info[0] << target_arr
  sentences_info[1] << phonetic_arr_from_base_arr(target_arr)
  sentences_info[2] << return_word_array(sentences_info[2][0])
end

# returns a word record if one is suitable in the user's scores section.
def word_from_scores(user_map)
  max_score = template = { entry: -1 }
  user_map.user_scores.where(status: TESTED).each do |score|
    next if score.entry > THRESHOLD
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

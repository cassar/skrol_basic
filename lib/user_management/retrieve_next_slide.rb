# Will retrieve an object containing the html representation of the slide.
def retrieve_next_slide(user_map)
  target_word, target_sentence = return_next_available_entries(user_map)
  return_html_slide(target_sentence, user_map)
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
  loop do
    sentence, correct_rank_found =
      search_rep_sents(target_word, user_map, user_score)
    return sentence if sentence.present?
    return nil unless correct_rank_found
  end
end

# Searches through a group of rep sents to see if a next sentence can be found
def search_rep_sents(target_word, user_map, user_score)
  lang_map_id = user_map.lang_map.id
  entry = user_score.sentence_rank
  rep_sent = RepSent.joins(:ranks).find_by ranks: { lang_map_id: lang_map_id,
                                                    entry: entry },
                                           word_id: target_word.id
  return [nil, false] if rep_sent.nil?
  user_score.increment_sentence_rank
  return [nil, true] if sentence_used?(rep_sent.rep_sent_id, user_map) || !sent_good?(Sentence.find(rep_sent.rep_sent_id))
  [Sentence.find(rep_sent.rep_sent_id), true]
end

# Returns the HTML slide to be sent to the client.
def return_html_slide(target_sentence, user_map)
  content = return_div_content(target_sentence, user_map)
  group = "data-sentence-group=\"#{target_sentence.group_id}\""
  map = "data-usermap-id=\"#{user_map.id}\""
  entry = "<div class=\"sentences\" #{group} #{map}>#{content}</div>"
  { entry: entry }
end

# Returns slide divided into its html elements
def return_div_content(target_sentence, user_map)
  sentences_info = compile_sentences_info(target_sentence, user_map)
  content = ''
  sentences_info.each do |element|
    compile_sentence_html(element, content)
  end
  content
end

# Compiles the array that will be used to convert to html
def compile_sentences_info(target_sentence, user_map)
  sentences_info =
    [[target_sentence, 'target'], [target_sentence.phonetic, 'phonetic'],
     [target_sentence.corresponding(user_map.base_script), 'base']]
  add_record_arrs(sentences_info)
  sentences_info.each { |element| element << element[SENTENCE].entry.split }
  sentences_info
end

# Add the record arrs to the sentences_info obeject
def add_record_arrs(sentences_info)
  target_arr = return_word_array(sentences_info[TARGET][SENTENCE])
  sentences_info[TARGET] << target_arr
  sentences_info[PHONETIC] << phonetic_arr_from_base_arr(target_arr)
  sentences_info[BASE] << return_word_array(sentences_info[BASE][SENTENCE])
end

# Compiles sentence info into html content
def compile_sentence_html(element, content)
  html_sent = ''
  counter = 0
  element[ENTRY_ARR].each do |entry|
    html_sent << return_html_sent(element, counter, entry)
    counter += 1
  end
  content << "<div class=\"sentence #{element[NAME]}\">#{html_sent}</div>"
end

# Returns the HTML representation of a sentence
def return_html_sent(element, counter, entry)
  group_id = element[RECORD_ARR][counter].group_id
  word_id = element[RECORD_ARR][counter].id
  assoc_id = element[RECORD_ARR][counter].assoc_id
  "<div class=\"word\"data-word-group=\"#{group_id}\""\
  "data-word-id=\"#{word_id}\" data-word-assoc=\"#{assoc_id}\""\
  "> #{entry}</div>&nbsp"
end

# returns a word record if one is suitable in the user's scores section.
def word_from_scores(user_map)
  max_score = template = { entry: -1 }
  user_map.user_scores.where(status: TESTED).each do |score|
    next if score.entry >= THRESHOLD
    max_score = score if score.entry > max_score[:entry]
  end
  return nil if max_score == template
  Word.find(max_score.target_word_id)
end

# Retrieves the next Word record from a the Word table for a User
def word_from_words(user_map)
  word_rank = user_map.word_rank
  word = nil
  loop do
    word = word_by_rank(user_map, word_rank)
    break unless word_used?(word, user_map) || !word_good?(word)
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
  entry_arr.each { |entry| word_arr << script.word_by_entry(entry) }
  word_arr
end

# Return phonetic array of a base array
def phonetic_arr_from_base_arr(base_arr)
  word_arr = []
  base_arr.each { |word| word_arr << word.phonetic }
  word_arr
end

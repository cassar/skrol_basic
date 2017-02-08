# Returns a user_score record given a user_metric record
def user_score_by_metric(metric)
  user_map = metric.user_map
  user_map.user_scores.find_by! target_word_id: metric.target_word_id
end

# Returns true if a word has (already) been viewed by a user, false otherwise
def word_used?(word, user_map)
  score = user_map.user_scores.find_by target_word_id: word.id
  return false if score.nil?
  true
end

# Returns true if a sentence has already been viewed by a user, false otherwise
def sentence_used?(sentence_id, user_map)
  metric = user_map.user_metrics.find_by target_sentence_id: sentence_id
  return false if metric.nil?
  true
end

# Returns an object with user_map id's and Language name's for a user
def lang_info(user)
  lang_arr = []
  user.user_maps.each do |user_map|
    lang_name = user_map.target_script.language.name
    lang_arr << [lang_name, user_map.id]
  end
  lang_arr
end

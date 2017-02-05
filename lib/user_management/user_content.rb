# Returns a User record given an id
def user_by_id(id)
  user = User.where(id: id).first
  raise Invalid, "No user with id: #{id} found!" if user.nil?
  user
end

# Returns a user_score record given a user_metric record
def user_score_by_metric(metric)
  user_map = metric.user_map
  score = user_map.user_scores.where(target_word_id: metric.target_word_id).first
  raise Invalid, "No score for metric.id: #{metric.id} found" if score.nil?
  score
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

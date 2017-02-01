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

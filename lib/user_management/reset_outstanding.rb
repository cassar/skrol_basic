# Resets outstanding user_scores and metrics when a new session is started?
# User resets the browser? Signs on after a while?
def reset_outstanding(user_map)
  scores = user_map.user_scores.where(status: TESTING)
  scores.each { |score| score.update(status: TESTED) }
  user_map.user_metrics.where(speed: nil).destroy_all
end

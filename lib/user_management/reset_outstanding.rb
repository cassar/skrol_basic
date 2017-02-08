# Resets outstanding user_scores and metrics when a new session is started?
# User resets the browser? Signs on after a while?
def reset_outstanding(user_map)
  user_map.user_scores.where(status: TESTING).each do |score|
    score.update(status: TESTED)
    next unless score.sentence_rank > 1
    score.update(sentence_rank: score.sentence_rank - 1)
  end
  user_map.user_metrics.where(speed: nil).destroy_all
end

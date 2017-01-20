class User < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :user_scores
  has_many :user_metrics
  has_many :user_maps

  # Either creates or a new user_score record or updates an existing one with
  # status 'testing'.
  def create_touch_score(target_word)
    score = user_scores.where(target_word_id: target_word.id).first
    if score.nil?
      user_scores.create(target_word_id: target_word.id, entry: START_SCORE,
                         status: TESTING)
    else
      score.update(status: TESTING)
    end
  end

  # Creates new user metric stub as placeholder while sentence is tested
  def create_metric_stub(target_word, target_sentence)
    user_metrics.create(target_word_id: target_word.id,
                        target_sentence_id: target_sentence.id)
  end

  def raise_to_threshold(target_word)
    score = user_scores.where(target_word_id: target_word.id).first
    if score.nil?
      user_scores.create(target_word_id: target_word.id, entry: THRESHOLD,
                         status: TESTED)
    else
      score.update(status: TESTED, entry: THRESHOLD)
    end
  end
end

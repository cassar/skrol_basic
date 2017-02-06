class UserMap < ApplicationRecord
  validates :user_id, :lang_map_id, :word_rank, presence: true
  validates :user_id, uniqueness: { scope: :lang_map_id }
  has_many :user_scores
  has_many :user_metrics
  belongs_to :user

  # Returns the lang_map of a give user_map
  def lang_map
    lang_map = LangMap.where(id: lang_map_id).first
    raise Invalid, "No lang_map with id #{lang_map_id} found" if lang_map.nil?
    lang_map
  end

  # Returns the base_script of a given user_map
  def base_script
    lang_map.base_script
  end

  # Returns the target script of a given user_map
  def target_script
    lang_map.target_script
  end

  # Either creates or a new user_score record or updates an existing one with
  # status TESTING.
  def create_touch_score(target_word)
    score = user_scores.where(target_word_id: target_word.id).first
    if score.nil?
      user_scores.create(target_word_id: target_word.id, entry: START_SCORE,
                         status: TESTING, sentence_rank: 1)
    else
      score.update(status: TESTING)
    end
  end

  # Creates new user metric stub as placeholder while sentence is tested
  def create_metric_stub(target_word, target_sentence)
    user_metrics.create(target_word_id: target_word.id,
                        target_sentence_id: target_sentence.id)
  end

  # Raises a target_word's score to the THRESHOLD value so that it will not
  # be tested any time soon.
  def raise_to_threshold(target_word)
    score = user_scores.where(target_word_id: target_word.id).first
    if score.nil?
      user_scores.create(target_word_id: target_word.id, entry: THRESHOLD,
                         status: TESTED)
    else
      score.update(status: TESTED, entry: THRESHOLD)
    end
  end

  # Retrieves a user_score given a target_word.
  def retrieve_user_score(target_word)
    user_score = user_scores.where(target_word_id: target_word.id).first
    raise Invalid, "No user_score word.id: #{target_word.id}" if user_score.nil?
    user_score
  end
end

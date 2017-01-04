class User < ApplicationRecord
  validates :name, :base_lang, presence: true
  validates :name, uniqueness: true
  has_many :user_scores
  has_many :user_metrics

  # Returns a base_script of the user record
  def base_script
    lang_by_id(base_lang).base_script
  end

  # Returns a base_sentence given for a user given a target sentence
  def base_sentence(target_sentence)
    sent = base_script.sentences.where(group_id: target_sentence.group_id).first
    message = "No base_sentence found for target.id: #{target_sentence.id}"
    raise Invalid, message if sent.nil?
    sent
  end

  # Either creates or a new user_score record or updates an existing one with
  # status 'testing'.
  def create_touch_score(target_word)
    score = user_scores.where(target_word_id: target_word.id).first
    if score.nil?
      user_scores.create(target_word_id: target_word.id, entry: START_SCORE,
                         status: 'testing')
    else
      score.update(status: 'testing')
    end
  end

  # Creates new user metric stub as placeholder while sentence is tested
  def create_metric_stub(target_word, target_sentence)
    user_metrics.create(target_word_id: target_word.id,
                        target_sentence_id: target_sentence.id)
  end
end

class UserMetric < ApplicationRecord
  validates :user_id, :target_word_id, :target_sentence_id, presence: true
  validates :user_id, uniqueness: { scope: [:target_word_id,
                                            :target_sentence_id] }
  belongs_to :user
end

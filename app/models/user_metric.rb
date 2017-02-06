class UserMetric < ApplicationRecord
  validates :user_map_id, :target_word_id, :target_sentence_id, presence: true
  validates :user_map_id, uniqueness: { scope: [:target_word_id,
                                                :target_sentence_id] }
  belongs_to :user_map

  def apply_user_score
    score = user_score_by_metric(self)
    new_entry = return_user_word_score(self, score)
    score.update(entry: new_entry)
    new_entry
  end
end

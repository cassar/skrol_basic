class UserMetric < ApplicationRecord
  validates :user_score, :sentence, presence: true
  validates :user_score, uniqueness: { scope: [:sentence] }
  belongs_to :user_score
  has_one :word, through: :user_score
  belongs_to :sentence

  def apply_user_score
    new_entry = return_user_word_score(user_score.entry)
    user_score.update(entry: new_entry)
    new_entry
  end

  private

  # Returns a new word score entry given the metric and score records
  def return_user_word_score(old_entry)
    old_entry += HIDE_BONUS if hide
    old_entry += NORMAL_BONUS unless pause
    old_entry -= PAUSE_PENALTY if pause
    old_entry -= HOVER_PENALTY if hover
    return 0.0 if old_entry < 0.0
    old_entry
  end
end

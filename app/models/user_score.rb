class UserScore < ApplicationRecord
  validates :user_id, :target_word_id, :entry, :status, presence: true
  validates :user_id, uniqueness: { scope: :target_word_id }
  belongs_to :user

  # Returns the target script of a user_score record
  def target_script
    word_by_id(target_word_id).script
  end
end

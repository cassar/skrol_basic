class UserScore < ApplicationRecord
  validates :user_map_id, :target_word_id, :entry, :status, presence: true
  validates :user_map_id, uniqueness: { scope: :target_word_id }
  belongs_to :user_map

  # Returns the target script of a user_score record
  def target_script
    word_by_id(target_word_id).script
  end
end

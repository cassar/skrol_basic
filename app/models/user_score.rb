class UserScore < ApplicationRecord
  validates :user_id, :target_word_id, :score, :status, presence: true
  validates :user_id, uniqueness: { scope: :target_word_id }
  belongs_to :user
end

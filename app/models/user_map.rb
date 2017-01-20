class UserMap < ApplicationRecord
  validates :user_id, :base_lang, :target_lang, :rank_num, presence: true
  validates :user_id, uniqueness: { scope: [:base_lang, :target_lang] }
  has_one :user
end

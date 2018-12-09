class Contributor < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :user_id, uniqueness: { scope: :language_id,
                                    message: 'User already a contributor for this language' }
end

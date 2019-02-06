class Contributor < ApplicationRecord
  belongs_to :user
  belongs_to :language

  validates :user, uniqueness: { scope: :language,
                                 message: 'already a contributor for this language' }
end

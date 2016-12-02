class Character < ApplicationRecord
  validates :entry, presence: true
  belongs_to :script
  has_one :language, through: :script
end

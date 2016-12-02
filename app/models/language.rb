class Language < ApplicationRecord
  validates :name, presence: true
  has_many :scripts
  has_many :characters, through: :scripts
end

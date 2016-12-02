class Language < ApplicationRecord
  validates :name, presence: true
  has_many :scripts
  has_many :characters, through: :scripts
  has_many :words, through: :scripts
end

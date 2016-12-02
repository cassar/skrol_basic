class Language < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :scripts
  has_many :characters, through: :scripts
  has_many :words, through: :scripts
  has_many :sentences, through: :scripts
end

class Language < ApplicationRecord
  validates :name, presence: true
  has_many :scripts
end

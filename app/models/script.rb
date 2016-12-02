class Script < ApplicationRecord
  validates :name, :language_id, presence: true
  belongs_to :language
  has_many :characters
end

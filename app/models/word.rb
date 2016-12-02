class Word < ApplicationRecord
  validates :entry, :script_id, presence: true
  belongs_to :script
  has_one :language, through: :script
end

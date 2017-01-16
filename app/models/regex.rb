class Regex < ApplicationRecord
  validates :entry, :script_id, presence: true
  belongs_to :script
end

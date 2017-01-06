class Character < ApplicationRecord
  # validates presence removed because I need to save a ' '
  # validates :entry, presence: true
  validates :entry, uniqueness: { scope: :script_id }
  belongs_to :script
  has_one :language, through: :script
  has_many :scores, as: :entriable, dependent: :destroy
end

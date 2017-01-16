class Character < ApplicationRecord
  # validates presence removed because I need to save a ' '
  # validates :entry, presence: true
  validates :entry, uniqueness: { scope: :script_id }
  belongs_to :script
  has_one :language, through: :script
  has_many :scores, as: :entriable, dependent: :destroy

  def create_cfs(score)
    scores.create(map_to_id: script.id, map_to_type: 'Script',
                  name: 'CFS', entry: score)
  end
end

class MetaDatum < ApplicationRecord
  validates :contentable_id, :contentable_type, :source, presence: true
  validates :contentable_id, uniqueness: { scope: %i[source contentable_type] }
  belongs_to :contentable, polymorphic: true
  serialize :entry, Hash
  belongs_to :source
end

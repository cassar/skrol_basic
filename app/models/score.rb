class Score < ApplicationRecord
  validates :entriable_id, :entriable_type, :map_to_id, :map_to_type,
            :score_name, :score, presence: true
  validates :score_name, uniqueness: { scope: [:map_to_id, :map_to_type] }
  belongs_to :entriable, polymorphic: true
end

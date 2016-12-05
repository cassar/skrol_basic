class Score < ApplicationRecord
  validates :entriable_id, :entriable_type, :map_to_id, :map_to_type,
            :score_name, :score, presence: true
  validates :entriable_id, uniqueness: { scope: [:entriable_type, :map_to_id,
                                                 :map_to_type, :score_name] }
  belongs_to :entriable, polymorphic: true
  # score_name and map_to_type should only accept certain values!
end

class Rank < ApplicationRecord
  validates :entriable_id, :entriable_type, :lang_map_id, :entry, presence: true
  validates :entriable_id, uniqueness: { scope: [:lang_map_id,
                                                 :entriable_type] }
  belongs_to :entriable, polymorphic: true
end

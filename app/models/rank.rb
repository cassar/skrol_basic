class Rank < ApplicationRecord
  validates :word_id, :lang_map_id, :rank_num, presence: true
  validates :word_id, uniqueness: { scope: :lang_map_id }

  belongs_to :word
end

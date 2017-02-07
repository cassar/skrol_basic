class RepSent < ApplicationRecord
  validates :word_id, :rep_sent_id, presence: true
  validates :word_id, uniqueness: { scope: :rep_sent_id }
  belongs_to :word
  has_many :ranks, as: :entriable, dependent: :destroy

  # Creates or updates
  def create_update_rank(lang_map, entry)
    rank = ranks.find_by(lang_map_id: lang_map.id)
    if rank.nil?
      ranks.create(lang_map_id: lang_map.id, entry: entry)
    else
      rank.update(entry: entry)
    end
  end
end

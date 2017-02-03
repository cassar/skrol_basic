class RepSent < ApplicationRecord
  validates :word_id, :rep_sent_id, presence: true
  validates :word_id, uniqueness: { scope: :rep_sent_id }
  belongs_to :word
  has_many :ranks, as: :entriable, dependent: :destroy

  # Creates or updates
  def create_update_rank(lang_map, entry)
    rank = ranks.where(lang_map_id: lang_map.id).first
    if rank.nil?
      ranks.create(lang_map_id: lang_map.id, entry: entry)
    else
      rank.update(entry: entry)
    end
  end

  # Returns the rank attached mapped to particular lang_map through given
  # user_map
  def retrieve_rank(user_map)
    ranks.where(lang_map_id: user_map.lang_map.id).first
  end
end

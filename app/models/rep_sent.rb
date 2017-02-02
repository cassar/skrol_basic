class RepSent < ApplicationRecord
  validates :word_id, :rep_sent_id, presence: true
  validates :word_id, uniqueness: { scope: :rep_sent_id }
  validates :word_id, uniqueness: { scope: :sentence_rank }
  belongs_to :word
end

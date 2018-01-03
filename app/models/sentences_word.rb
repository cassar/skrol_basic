class SentencesWord < ApplicationRecord
  validates :word, :sentence, presence: true
  validates :word, uniqueness: { scope: :sentence }
  belongs_to :word
  belongs_to :sentence
end

class WordScore < ApplicationRecord
  validates :word, :course, :entry, :rank, presence: true
  validates :word, uniqueness: { scope: :course }
  belongs_to :word
  belongs_to :course
end

class SentenceScore < ApplicationRecord
  validates :sentence, :course, :sentence, :entry, presence: true
  validates :sentence, uniqueness: { scope: :course }
  belongs_to :sentence
  belongs_to :course
end

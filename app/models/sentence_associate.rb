class SentenceAssociate < ApplicationRecord
  validates :associate_a, :associate_b, presence: true
  validates :associate_a, uniqueness: { scope: :associate_b }
  belongs_to :associate_a, class_name: 'Sentence'
  belongs_to :associate_b, class_name: 'Sentence'
  serialize :representations, Array
  has_many :meta_data, as: :contentable, dependent: :destroy

  def word_associates(corresponding_sentence)
    rep_a, rep_b = representations
    return WordAssociate.find(rep_a) if corresponding_sentence.id == associate_a_id
    WordAssociate.find(rep_b)
  end
end

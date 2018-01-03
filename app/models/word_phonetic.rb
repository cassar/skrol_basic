class WordPhonetic < ApplicationRecord
  validates :standard, :phonetic, presence: true
  validates :standard, uniqueness: { scope: :phonetic }
  belongs_to :standard, class_name: 'Word'
  belongs_to :phonetic, class_name: 'Word'
  has_many :meta_data, as: :contentable, dependent: :destroy
end

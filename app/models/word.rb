class Word < ApplicationRecord
  validates :entry, :script_id, presence: true
  validates :entry, uniqueness: { scope: :script_id }
  belongs_to :script
  has_one :language, through: :script
  has_many :meta_data, as: :contentable, dependent: :destroy

  has_many :standard_word_phonetics, foreign_key: 'phonetic_id', class_name: 'WordPhonetic', dependent: :destroy
  has_many :standards, through: :standard_word_phonetics, source: :standard

  has_many :phonetic_word_phonetics, foreign_key: 'standard_id', class_name: 'WordPhonetic', dependent: :destroy
  has_many :phonetics, through: :phonetic_word_phonetics, source: :phonetic

  def standard
    standards.take unless standards.empty?
  end

  def phonetic
    phonetics.take unless phonetics.empty?
  end

  has_many :associate_b_word_associates, foreign_key: 'associate_a_id', class_name: 'WordAssociate', dependent: :destroy
  has_many :associate_bs, through: :associate_b_word_associates, source: :associate_b

  has_many :associate_a_word_associates, foreign_key: 'associate_b_id', class_name: 'WordAssociate', dependent: :destroy
  has_many :associate_as, through: :associate_a_word_associates, source: :associate_a

  def all_associates
    associate_as | associate_bs
  end

  def new_associate(new_associate)
    associate_as << new_associate
  end

  # returns a corresponding word given a corresponding_script.
  def corresponding(corr_script)
    all_associates.each { |w| return w if w.script_id == corr_script.id }
  end

  has_many :sentences_words
  has_many :sentences, through: :sentences_words
end

class Script < ApplicationRecord
  validates :name, :language, presence: true
  validates :name, uniqueness: { scope: :language }
  belongs_to :language
  has_many :words
  has_many :word_meta_data, through: :words, source: :meta_data
  has_many :sentences
  has_many :sentence_meta_data, through: :sentences, source: :meta_data
  has_many :meta_data, as: :contentable

  has_many :sentences_words, through: :sentences
  has_many :sentence_linked_words, through: :sentences, source: :words

  def phonetic
    Script.find_by standard_id: id
  end

  def standard
    Script.find_by id: standard_id
  end

  has_many :standard_word_phonetics, foreign_key: 'phonetic_id', class_name: 'WordPhonetic', dependent: :destroy
  has_many :standards, through: :standard_word_phonetics, source: :standard

  has_many :phonetic_word_phonetics, foreign_key: 'standard_id', class_name: 'WordPhonetic', dependent: :destroy
  has_many :phonetics, through: :phonetic_word_phonetics, source: :phonetic

  has_many :phonetic_word_phonetics, through: :words

  has_many :associate_sents_bs, through: :sentences, source: :associate_bs
  has_many :associate_sents_as, through: :sentences, source: :associate_as

  def associate_sentences(corr_script)
    assoc_bs = associate_sents_bs.where(script: corr_script)
    assoc_as = associate_sents_as.where(script: corr_script)
    assoc_bs | assoc_as
  end

  has_many :associate_b_word_associates, through: :words
  has_many :associate_a_word_associates, through: :words
  has_many :word_b_meta_data, through: :associate_a_word_associates, source: :meta_data
  has_many :word_a_meta_data, through: :associate_a_word_associates, source: :meta_data

  def word_associates(associate_script = nil)
    these_assocs = all_word_associates
    return these_assocs if associate_script.nil?
    these_assocs & associate_script.word_associates
  end

  has_many :associate_b_sentence_associates, through: :sentences
  has_many :associate_a_sentence_associates, through: :sentences

  def sentence_associates(associate_script = nil)
    these_assocs = all_sentence_associates
    return these_assocs if associate_script.nil?
    these_assocs & associate_script.sentence_associates
  end

  def suitable_sentence_associates(associate_script = nil)
    these_suitable = all_suitable_associates
    return these_suitable if associate_script.nil
    these_suitable & associate_script.suitable_sentence_associates
  end

  def words_with_phonetics
    phonetic_none_sentinal = SentinalManager.retrieve(phonetic)
    words - phonetic_none_sentinal.standards
  end

  private

  def all_word_associates
    associate_b_word_associates | associate_a_word_associates
  end

  def all_sentence_associates
    associate_b_sentence_associates | associate_a_sentence_associates
  end

  def all_suitable_associates
    as = associate_a_sentence_associates.where.not(representatons: nil)
    bs = associate_b_sentence_associates.where.not(representatons: nil)
    as | bs
  end
end

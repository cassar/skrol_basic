class Sentence < ApplicationRecord
  validates :entry, :script, presence: true
  validates :entry, uniqueness: { scope: :script_id }
  belongs_to :script
  has_one :language, through: :script
  has_many :meta_data, as: :contentable, dependent: :destroy

  has_many :associate_b_sentence_associates, foreign_key: 'associate_a_id',
                                             class_name: 'SentenceAssociate', dependent: :destroy
  has_many :associate_bs, through: :associate_b_sentence_associates, source: :associate_b

  has_many :associate_a_sentence_associates, foreign_key: 'associate_b_id',
                                             class_name: 'SentenceAssociate', dependent: :destroy
  has_many :associate_as, through: :associate_a_sentence_associates, source: :associate_a

  def all_associates
    associate_as + associate_bs
  end

  def new_associate(new_associate)
    associate_as << new_associate
  end

  def associate_and_corresponding(corr_script)
    corr_sentence = corresponding(corr_script)
    ids = [id, corr_sentence.id]
    assoc = SentenceAssociate.find_by(associate_a_id: ids, associate_b_id: ids)
    [assoc, corr_sentence]
  end

  # returns a corresponding sentence given a corresponding_script.
  def corresponding(corr_script)
    (associate_as.where(script: corr_script) | associate_bs.where(script: corr_script)).first
  end

  has_many :sentences_words, dependent: :destroy
  has_many :words, through: :sentences_words
end

class Course < ApplicationRecord
  validates :language_map, presence: true
  belongs_to :language_map
  has_many :word_scores, dependent: :destroy
  has_many :words, through: :word_scores
  has_many :sentence_scores, dependent: :destroy
  has_many :sentences, through: :sentence_scores
  has_many :sentences_words, through: :sentences
  has_many :enrolments
  has_many :meta_data, as: :contentable, dependent: :destroy

  def info
    old_logger = logger_off
    base_name, target_name = retrieve_info
    puts "Course from #{base_name} to #{target_name}\ncreated at: #{created_at}"
    puts "Word count: #{word_scores.count}\nSentence count: #{sentence_scores.count}"
    puts "Enrolments: #{enrolments.count}"
    logger_on(old_logger)
  end

  def create_metadatum
    entry = { max_length_map: MAX_LENGTH_MAP }
    entry[:WCFBSW] = WCFBSW
    entry[:WCFTSW] = WCFTSW
    entry[:WFSW] = WFSW
    entry[:WLSW] = WLSW
    entry[:WSSW] = WSSW
    entry[:SCWTSW] = SCWTSW
    entry[:SWLSW] = SWLSW
    entry[:SWOSW] = SWOSW
    meta_data.create(source: COURSE_CREATOR, entry: entry)
  end

  private

  def retrieve_info
    base_name = language_map.base_language.name
    target_name = language_map.target_language.name
    [base_name, target_name]
  end
end

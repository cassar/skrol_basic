class Course < ApplicationRecord
  validates :language_map, presence: true
  belongs_to :language_map
  has_many :word_scores, dependent: :destroy
  has_many :words, through: :word_scores
  has_many :sentence_scores, dependent: :destroy
  has_many :sentences, through: :sentence_scores
  has_many :sentences_words, through: :sentences
  has_many :enrolments, dependent: :destroy

  def info
    old_logger = logger_off
    base_name, target_name = retrieve_info
    puts "Course from #{base_name} to #{target_name}\ncreated at: #{created_at}"
    puts "Word count: #{word_scores.count}\nSentence count: #{sentence_scores.count}"
    puts "Enrolments: #{enrolments.count}"
    logger_on(old_logger)
  end

  def create_enrolments
    Student.all.each { |s| s.enrolments.create(course: self) }
  end

  private

  def retrieve_info
    base_name = language_map.base_language.name
    target_name = language_map.target_language.name
    [base_name, target_name]
  end
end

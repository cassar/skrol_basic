class LanguageMap < ApplicationRecord
  validates :base_language, :target_language, presence: true
  validates :base_language, uniqueness: { scope: :target_language }
  has_many :courses, dependent: :destroy

  belongs_to :base_language, class_name: 'Language'
  belongs_to :target_language, class_name: 'Language'

  # Will return the base_script for a LanguageMap
  def base_script
    base_language.standard_script
  end

  # Will return the target_script for a LanguageMap
  def target_script
    target_language.standard_script
  end

  def latest_course
    courses.order(:created_at).last
  end

  def destroy_old_courses
    latest = latest_course
    courses.each { |course| course.destroy unless course == latest }
  end

  # Print out useful information about the instance
  def info
    old_logger = logger_off
    lang_map_info
    sentence_info
    word_info
    logger_on(old_logger)
  end

  def self.info
    all.each { |lm| lm.info + "\n" }
  end

  private

  def lang_map_info
    base_name = base_script.language.name
    target_name = target_script.language.name
    puts "Base Language: #{base_name}\nTarget Language: #{target_name}"
  end

  def sentence_info
    puts "#{base_script.sentence_associates(target_script).count} sentence associates."
  end

  def word_info
    puts "#{base_script.word_associates(target_script).count} word associates."
  end
end

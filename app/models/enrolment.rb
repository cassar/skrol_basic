class Enrolment < ApplicationRecord
  validates :course, presence: true
  validates :student, uniqueness: { scope: :course }
  belongs_to :student
  belongs_to :course
  has_many :user_scores
  has_many :user_metrics, through: :user_scores
  has_many :sentences, through: :user_metrics
  has_one :language_map, through: :course

  # Returns the base_script of a given enrolment
  def base_script
    language_map.base_script
  end

  # Returns the target script of a given enrolment
  def target_script
    language_map.target_script
  end

  # Prints out useful information about the record.
  def info
    old_logger = logger_off
    InfoHelper.new(self).print_info
    logger_on(old_logger)
  end

  # Clears all user_metrics and all user_scores from the language maps
  def reset
    old_logger = logger_off
    user_scores.destroy_all
    logger_on(old_logger)
    puts "All metrics and scores from enrolment id: #{id} destroyed"
  end

  def update_to_latest_course
    update(course: language_map.courses.order(:created_at).last)
  end

  class InfoHelper
    def initialize(enrolment)
      lang_map = enrolment.language_map
      @course = enrolment.course
      @base_name = lang_map.base_language.name
      @target_name = lang_map.target_language.name
      assign_score_metric_counts(enrolment)
      assign_status_counts(enrolment)
    end

    def print_info
      puts "Course id: #{@course.id}, create_at: #{@course.created_at}"
      puts "From Language: #{@base_name}\nTo Language: #{@target_name}"
      puts "UserScore count: #{@user_score_count}"
      puts "UserMetric count: #{@user_metric_count}"
      puts "Sentences viewed: #{@sentences_count}"
      puts "Words 'testing': #{@testing_count}"
      puts "Words 'tested': #{@tested_count}"
      puts "Words 'exhausted': #{@exhausted_count}"
      puts "Words past Acquiry Point: #{@acquired}"
    end

    private

    def assign_score_metric_counts(enrolment)
      @user_score_count = enrolment.user_scores.count
      @user_metric_count = enrolment.user_metrics.count
      @sentences_count = enrolment.sentences.uniq.count
    end

    def assign_status_counts(enrolment)
      @testing_count = enrolment.user_scores.where(status: TESTING).count
      @tested_count = enrolment.user_scores.where(status: TESTED).count
      @exhausted_count = enrolment.user_scores.where(status: EXHAUSTED).count
      @acquired = enrolment.user_scores.where('entry > ?', ACQUIRY_POINT).count
    end
  end
end

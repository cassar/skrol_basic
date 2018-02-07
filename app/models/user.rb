class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  validates :name, presence: true
  validates :name, uniqueness: true
  has_one :student, dependent: :destroy
  has_many :enrolments, through: :student
  has_many :user_scores, through: :enrolments
  has_many :user_metrics, through: :user_scores

  # Prints out useful information about the user
  def info
    puts "Name: #{name}"
    enrolments.each(&:info)
    nil
  end

  def lang_info
    create_student_and_enrolments if student.nil?
    lang_arr = []
    student.enrolments.each do |enrolment|
      lang_name = enrolment.target_script.language.name
      lang_arr << [lang_name, enrolment.id]
    end
    lang_arr
  end

  def user_info
    user_info = {}
    user_info[:current_speed] = student.current_speed
    user_info[:base_hidden] = student.base_hidden
    scores = student.user_scores.order(updated_at: :desc)
    user_info[:current_enrolment] = if scores.empty?
                                      NO_ENROLMENT_SET
                                    else
                                      scores.first.enrolment.id
                                    end
    user_info
  end

  # Resets outstanding user_scores and metrics when a new session is started?
  # User resets the browser? Signs on after a while?
  def reset_outstanding
    user_scores.where(status: TESTING).update_all(status: TESTED)
    user_metrics.where(speed: nil).destroy_all
  end

  # Wipes all user data from all languages attempted
  def reset
    enrolments.each(&:reset)
    puts "All metrics and scores from user '#{name}' destroyed"
  end

  private

  def create_student_and_enrolments
    base_lang = Language.first
    student = create_student(language: base_lang)
    LanguageMap.all.each do |lm|
      next unless lm.base_language == base_lang
      student.enrolments.create(course: lm.latest_course)
    end
  end
end

class User < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :enrolments
  has_many :user_scores, through: :enrolments
  has_many :user_metrics, through: :user_scores

  # Prints out useful information about the user
  def info
    puts "Name: #{name}"
    enrolments.each(&:info)
    nil
  end

  def lang_info
    lang_arr = []
    enrolments.each do |enrolment|
      lang_name = enrolment.target_script.language.name
      lang_arr << [lang_name, enrolment.id]
    end
    lang_arr
  end

  def user_info
    user_info = {}
    user_info[:current_speed] = current_speed
    user_info[:base_hidden] = base_hidden
    current_enrolment = user_scores.order(updated_at: :desc).first.enrolment.id
    user_info[:current_enrolment] = current_enrolment
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

  # Given a {'setting': value } will update the value for user.
  def update_setting(settings)
    settings.each do |setting, value|
      update(current_map: value.to_i) if setting == 'current_map'
      update(current_speed: value.to_i) if setting == 'current_speed'
      update(base_hidden: value) if setting == 'base_hidden'
      update(paused: value) if setting == 'paused'
    end
  end
end

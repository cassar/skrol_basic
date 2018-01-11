class Student < ApplicationRecord
  belongs_to :user
  has_many :enrolments
  has_many :user_scores, through: :enrolments

  # Given a {'setting': value } will update the value for student.
  def update_setting(settings)
    settings.each do |setting, value|
      update(current_speed: value.to_i) if setting == 'current_speed'
      update(base_hidden: value) if setting == 'base_hidden'
      update(paused: value) if setting == 'paused'
    end
  end
end

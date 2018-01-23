class Student < ApplicationRecord
  belongs_to :user
  has_many :enrolments
  has_many :user_scores, through: :enrolments
  belongs_to :language

  # Given a {'setting': value } will update the value for student.
  def update_setting(settings)
    settings.each do |setting, value|
      case setting
      when 'current_speed' then update(current_speed: value.to_i)
      when 'base_hidden' then update(base_hidden: value)
      when 'paused' then update(paused: value)
      end
    end
  end
end

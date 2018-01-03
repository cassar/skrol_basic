class UserScore < ApplicationRecord
  validates :enrolment, :word, :entry, :status, presence: true
  validates :enrolment, uniqueness: { scope: :word }
  belongs_to :enrolment
  belongs_to :word
  has_many :user_metrics, dependent: :destroy
end

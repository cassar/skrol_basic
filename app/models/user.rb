class User < ApplicationRecord
  validates :name, :base_lang, presence: true
  validates :name, uniqueness: true
  has_many :user_scores
  has_many :user_metrics
end

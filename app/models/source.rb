class Source < ApplicationRecord
  validates :name, uniqueness: true
  has_many :meta_data
end

class Key < ApplicationRecord
  validates :entry, uniqueness: true
end

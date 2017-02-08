class User < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :user_maps

  # Returns the current name of the language the user is viewing
  def current_name
    Language.find(current_lang).name
  end
end

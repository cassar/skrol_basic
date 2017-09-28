class User < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :user_maps

  # Returns the current name of the language the user is viewing
  def current_name
    Language.find(current_lang).name
  end

  def info
    user_maps.each {|user_map| user_map.info }
    return nil
  end

  # Wipes all user data from all languages attempted
  def reset
    user_maps.each { |user_map| user_map.reset }
    puts "All metrics and scores from user '#{name}' destroyed"
  end
end

class User < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :user_maps

  # Returns the current name of the language the user is viewing
  def current_name
    Language.find(current_lang).name
  end

  # Prints out useful information about the user
  def info
    user_maps.each {|user_map| user_map.info }
    return nil
  end

  # Resets outstanding user_scores and metrics when a new session is started?
  # User resets the browser? Signs on after a while?
  def reset_outstanding
    user_maps.each do |user_map|
      user_map.user_scores.where(status: TESTING).each do |score|
        score.update(status: TESTED)
        next unless score.sentence_rank > 1
        score.update(sentence_rank: score.sentence_rank - 1)
      end
      user_map.user_metrics.where(speed: nil).destroy_all
    end
  end

  # Wipes all user data from all languages attempted
  def reset
    user_maps.each { |user_map| user_map.reset }
    puts "All metrics and scores from user '#{name}' destroyed"
  end
end

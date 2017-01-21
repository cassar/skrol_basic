class UserMap < ApplicationRecord
  validates :user_id, :lang_map_id, :rank_num, presence: true
  validates :user_id, uniqueness: { scope: :lang_map_id }
  belongs_to :user

  # Returns the lang_map of a give user_map
  def lang_map
    lang_map = LangMap.where(id: lang_map_id).first
    raise Invalid, "No lang_map with id #{lang_map_id} found" if lang_map.nil?
    lang_map
  end

  # Returns the base_script of a given user_map
  def base_script
    lang_map.base_script
  end

  # Returns the target script of a given user_map
  def target_script
    lang_map.target_script
  end
end

class LangMap < ApplicationRecord
  validates :base_lang, :target_lang, presence: true
  validates :base_lang, uniqueness: { scope: :target_lang }

  # Will return the base_script for a LangMap
  def base_script
    Language.find(base_lang).base_script
  end

  # Will return the target_script for a LangMap
  def target_script
    Language.find(target_lang).base_script
  end

  # Print out useful information about the instance
  def info
    logger_off
    base_name = Language.find(base_lang).name
    target_name = Language.find(target_lang).name
    wr_count = Rank.where(lang_map_id: id, entriable_type: "Word").count
    rs_count = Rank.where(lang_map_id: id, entriable_type: "RepSent").count
    logger_on
    puts "Base Language: #{base_name}"
    puts "Target Language: #{target_name}"
    puts "Word Rank Count: #{wr_count}"
    puts "RepSent Rank Count: #{rs_count}"
  end
end

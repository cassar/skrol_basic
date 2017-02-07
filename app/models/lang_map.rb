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
end

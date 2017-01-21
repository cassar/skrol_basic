class LangMap < ApplicationRecord
  validates :base_lang, :target_lang, presence: true
  validates :base_lang, uniqueness: { scope: :target_lang }

  #
  def base_script
    lang = Language.where(id: base_lang).first
    raise Invalid, "no lang found for lang id #{base_lang}" if lang.nil?
    lang.base_script
  end

  #
  def target_script
    lang = Language.where(id: target_lang).first
    raise Invalid, "no lang found for lang id #{base_lang}" if lang.nil?
    lang.base_script
  end
end

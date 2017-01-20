class Map < ApplicationRecord
  validates :base_lang, :target_lang, presence: true
  validates :base_lang, uniqueness: { scope: :target_lang }
end

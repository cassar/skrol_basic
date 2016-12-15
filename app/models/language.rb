class Language < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :scripts
  has_many :characters, through: :scripts
  has_many :words, through: :scripts
  has_many :sentences, through: :scripts

  # Retrieves the base script of a language (assumes only one)
  def base_script
    script = scripts.where(parent_script_id: nil).first
    raise Invalid, 'No base_script found!' if script.nil?
    script
  end

  # Retrieves the phonetic script of a language (assumes only one)
  def phonetic_script
    base = base_script
    phonetic = scripts.where(parent_script_id: base.id).first
    raise Invalid, 'No phonetic_script found!' if phonetic.nil?
    phonetic
  end
end

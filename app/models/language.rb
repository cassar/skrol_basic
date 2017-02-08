class Language < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :scripts
  has_many :characters, through: :scripts
  has_many :words, through: :scripts
  has_many :sentences, through: :scripts

  # Retrieves the base script of a language (assumes only one)
  def base_script
    scripts.find_by! parent_script_id: nil
  end

  # Retrieves the phonetic script of a language (assumes only one)
  def phonetic_script
    scripts.find_by! parent_script_id: base_script.id
  end
end

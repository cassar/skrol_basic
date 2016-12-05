class Script < ApplicationRecord
  validates :name, :language_id, presence: true
  belongs_to :language
  has_many :characters
  has_many :words
  has_many :sentences

  # Returns the phonetic script of a particular base script.
  def phonetic
    script_arr = Script.where(parent_script_id: id)
    raise Invalid, 'No phonetic script found!' if script_arr.first.nil?
    script_arr.first
  end

  # Creates a new phonetic script for a base script.
  def create_phonetic(name)
    language.scripts.create(name: name, parent_script_id: id)
  end
end

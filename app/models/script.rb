class Script < ApplicationRecord
  validates :name, :language_id, presence: true
  validates :name, uniqueness: { scope: :language_id }
  belongs_to :language
  has_many :characters
  has_many :words
  has_many :sentences
  has_many :regexes

  # Returns the phonetic script of a particular base script.
  def phonetic
    Script.find_by! parent_script_id: id
  end

  # Creates a new phonetic script for a base script.
  def create_phonetic(name)
    language.scripts.create(name: name, parent_script_id: id)
  end

  # Returns the base script of a phonetic script
  def base
    Script.find(parent_script_id)
  end

  # Retrieves a word record from a script given an entry
  def word_by_entry(entry)
    words.find_by! entry: entry.downcase
  end
end

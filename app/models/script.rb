class Script < ApplicationRecord
  validates :name, :language_id, presence: true
  validates :name, uniqueness: { scope: :language_id }
  belongs_to :language
  has_many :characters
  has_many :words
  has_many :sentences

  # Returns the phonetic script of a particular base script.
  def phonetic
    script_arr = Script.where(parent_script_id: id)
    script_arr.first
  end

  # Creates a new phonetic script for a base script.
  def create_phonetic(name)
    language.scripts.create(name: name, parent_script_id: id)
  end

  # Retrieves a word record from a script given an entry
  def word_by_entry(entry)
    word = words.where(entry: entry).first
    raise Invalid, "No entry: #{entry} found" if word.nil?
    word
  end
end

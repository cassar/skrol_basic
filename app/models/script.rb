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
    phonetic = Script.where(parent_script_id: id).first
    raise Invalid, 'No phonetic script found' if phonetic.nil?
    phonetic
  end

  # Creates a new phonetic script for a base script.
  def create_phonetic(name)
    language.scripts.create(name: name, parent_script_id: id)
  end

  # Returns the base script of a phonetic script
  def base
    base = Script.where(id: parent_script_id).first
    raise Invalid, 'No base script found' if base.nil?
    base
  end

  # Retrieves a word record from a script given an entry
  def word_by_entry(entry)
    word = words.where(entry: entry.downcase).first
    raise Invalid, "No entry: #{entry} found" if word.nil?
    word
  end
end

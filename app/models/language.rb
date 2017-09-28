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

  # Prints out useful info about a particular language
  def info
    logger_off
    base_words = base_script.words.count
    base_sents = base_script.sentences.count
    phon_words = phonetic_script.words.count
    phon_sents = phonetic_script.sentences.count
    logger_on
    puts "Name: #{name}"
    puts "Base Word Count: #{base_words}"
    puts "Phonetic Word Count: #{phon_words}"
    puts "Base Sentence Count: #{base_sents}"
    puts "Phonetic Sentence Count: #{phon_sents}"
  end
end

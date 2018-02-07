class Language < ApplicationRecord
  validates :name, presence: true
  validates :name, uniqueness: true
  has_many :scripts
  has_many :words, through: :scripts
  has_many :sentences, through: :scripts
  has_many :standards, through: :scripts
  has_many :phonetics, through: :scripts

  has_many :lang_maps_as_base, foreign_key: 'base_language_id',
                               class_name: 'LanguageMap', dependent: :destroy
  has_many :lang_maps_as_target, foreign_key: 'target_language_id',
                                 class_name: 'LanguageMap', dependent: :destroy

  # Retrieves the standard script of a language (assumes only one)
  def standard_script
    scripts.find_by! standard_id: nil
  end

  # Retrieves the phonetic script of a language (assumes only one)
  def phonetic_script
    scripts.find_by! standard_id: standard_script.id
  end

  def self.all_info
    old_logger = logger_off
    all.each do |language|
      puts language.name
      puts "standard: #{language.standard_script.name}"
      puts "phonetic: #{language.phonetic_script.name}"
      puts ''
    end
    logger_on(old_logger)
  end

  # Prints out useful info about a particular language
  def info
    old_logger = logger_off
    InfoHelper.new(self).print
    logger_on(old_logger)
  end

  class InfoHelper
    def initialize(language)
      @language = language
      @standard_script = language.standard_script
      @phonetic_script = language.phonetic_script
      @std_word_count = @standard_script.words.count
    end

    def print
      language_info
      standard_sentence_info
      standard_word_info
      phonetic_word_info
    end

    def language_info
      puts "Name: #{@language.name}\nMetadata:"
      [@standard_script, @phonetic_script].each do |script|
        script.meta_data.each { |md| puts "Source: #{md.source}, entry: #{md.entry}" }
      end
      puts ''
    end

    def standard_sentence_info
      puts "Standard Sentences: #{@standard_script.sentences.count}"
      puts "#{@standard_script.sentence_associates.count} sentence associates."
      puts "#{@standard_script.sentences_words.count} sentence-word entries."
      puts ''
    end

    def standard_word_info
      puts "Standard Words: #{@std_word_count}"
      puts "#{@standard_script.word_associates.count} word associates."
      puts ''
    end

    def phonetic_word_info
      puts "Phonetic Words: #{@phonetic_script.words.count}"
      puts "#{@standard_script.phonetic_word_phonetics.count} word phonetics"
      none_count = @std_word_count - @standard_script.standard_word_phonetics.pluck(:standard_id).uniq.count
      puts "#{none_count} standard words without phonetic equivalents."
      puts ''
    end
  end
end

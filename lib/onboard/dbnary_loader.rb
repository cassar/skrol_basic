# The load_dbnary_lemon takes a standard_script and a phonetic script and will
# then load the word pairs in the lemon file,

# The method relies on the file being in the PROD_DEV_DIR and the phonetic
# script having a DBNARY meta_datum with the below attributes assign.

# The Metadatum can be assign below.
module DbnaryLoader
  def self.assign_meta_datum(phonetic_script, file_prefix, tags)
    entry = { file_prefix: file_prefix, tags: tags }
    phonetic_script.meta_data.create(source: DBNARY, entry: entry)
  end

  def self.load(phonetic_script)
    DbnaryHelper.new(phonetic_script).process
  end

  class DbnaryHelper
    def initialize(phonetic_script)
      @meta_datum = phonetic_script.meta_data.find_by source: DBNARY
      @new_pair = { standard: '', phonetic: '' }
      standard_script = phonetic_script.standard
      @std_word_entry_processor = WordEntryProcessor.new(standard_script, DBNARY)
      @phn_word_entry_processor = WordEntryProcessor.new(phonetic_script, DBNARY)
      @word_phonetic_manager = WordPhoneticManager.new(standard_script)
    end

    DBNARY_FILE_END = '_dbnary_lemon.ttl'.freeze
    ENTRY_GET_REGEX = /(?<=")(.*?)(?=")/
    PHON_CHECK_REGEX = /lexinfo:pronunciation/
    STD_CHECK_REGEX = /lemon:writtenRep/

    def process
      File.open(dbnary_file_name).each do |line|
        process_line(line)
      end
    end

    private

    def dbnary_file_name
      file_name = @meta_datum.entry[:file_prefix] + DBNARY_FILE_END
      return TEST_DIR + file_name if Rails.env.test?
      PROD_DEV_DIR + file_name
    end

    def process_line(line)
      assign_phon_entry(line) if line =~ PHON_CHECK_REGEX
      assign_standard_entry(line) if line =~ STD_CHECK_REGEX
      return if (@new_pair[:phonetic] == '') || (@new_pair[:standard] == '')
      investigate_word_pair
    end

    def assign_phon_entry(line)
      @new_pair[:phonetic] = {}
      @meta_datum[:entry][:tags].each do |tag|
        line.comma_tag_scan(tag).each do |entry|
          parse_and_assign_entry(entry, tag)
        end
      end
    end

    def assign_standard_entry(line)
      @new_pair[:standard] = line.scan(ENTRY_GET_REGEX).first
    end

    def investigate_word_pair
      phonetic_entry = ''
      @new_pair[:phonetic].each do |_tag, entry_arr|
        phonetic_entry = entry_arr.first
        break
      end
      create_word_pair(phonetic_entry)
      @new_pair[:phonetic] = ''
      @new_pair[:standard] = ''
    end

    def create_word_pair(phonetic_entry)
      return if phonetic_no_good?(phonetic_entry)
      standard_entry = @new_pair[:standard].first.downcase
      standard_word = @std_word_entry_processor.process(standard_entry, entries: @new_pair[:standard])
      phonetic_word = @phn_word_entry_processor.process(phonetic_entry, entries: @new_pair[:phonetic])
      @word_phonetic_manager.add(standard_word, phonetic_word)
    end

    def phonetic_no_good?(phonetic_entry)
      phonetic_entry.nil? || (phonetic_entry.length > MAX_LENGTH_WORD)
    end

    def parse_and_assign_entry(entry, tag)
      if entry =~ /\[ /
        entry.scan(/(?<=\[ )(.*?)(?= \])/).each do |sub_entry|
          assign_entry(sub_entry.first, tag)
        end
      else
        assign_entry(entry, tag)
      end
    end

    def assign_entry(entry, tag)
      @new_pair[:phonetic][tag] = [] if @new_pair[:phonetic][tag].nil?
      @new_pair[:phonetic][tag] << entry.clean_phonetic_entry
    end
  end
end

class String
  def clean_phonetic_entry
    gsub(%r{(\/|\*)}, '')
  end

  def comma_tag_scan(tag, arr = [])
    tag_index = index(/#{tag}/)
    return arr if tag_index.nil?
    end_comma = tag_index - 1
    candidate = 0
    each_char.with_index { |char, index| candidate = index if closest_comma?(char, index, candidate, end_comma) }
    self[(tag_index + tag.length)..-1].comma_tag_scan(tag, arr << self[(candidate + 1)...end_comma])
  end

  private

  def closest_comma?(char, index, candidate, end_comma)
    (char == '"') && (index > candidate) && (index < end_comma)
  end
end

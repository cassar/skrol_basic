require 'httparty'

module WiktionaryManager
  def self.create_metadatum(phonetic_script, regexes, lang_code)
    entry = { regexes: regexes, lang_code: lang_code }
    phonetic_script.meta_data.create(source: WIKI, entry: entry)
  end

  def self.bulk_check(phonetic_script)
    BulkManager.new(phonetic_script).process
  end

  def self.retrieve(standard_entry, phonetic_script)
    WiktionaryScraper.new(phonetic_script).process(standard_entry)
  end

  class BulkManager
    def initialize(phonetic_script)
      @phon_word_updater = PhoneticWordUpdater.new(phonetic_script, WIKI)
      @wiki_scraper = WiktionaryScraper.new(phonetic_script)
    end

    THREAD_CONTROL = 10

    def process
      threads = []
      THREAD_CONTROL.times { threads << Thread.new { thread_process } }
      threads.each(&:join)
    end

    def thread_process
      loop do
        return if (std_word = @phon_word_updater.next_word).nil?
        @phon_word_updater.update(std_word, phn_entry = @wiki_scraper.process(std_word.entry))
        puts "phn_entry_returned '#{phn_entry}'"
      end
    end
  end

  class WiktionaryScraper
    def initialize(phonetic_script)
      meta_entry = phonetic_script.meta_data.find_by(source: WIKI).entry
      @regexes = meta_entry[:regexes]
      @lang_code = meta_entry[:lang_code]
      standard_script = phonetic_script.standard
      @phn_manager = PhoneticWordManager.new(standard_script, phonetic_script)
    end

    def process(standard_entry)
      ipa_entry = request_lower_and_capitalize(standard_entry)
      return ipa_entry unless ipa_entry.nil? || ipa_entry == ''
      return NONE unless standard_entry.match(/\s|\'|\-/).present?
      ipa_entry = process_multiple_words(standard_entry)
      return NONE if ipa_entry.nil? || ipa_entry == ''
      ipa_entry
    end

    private

    def process_multiple_words(standard_entry)
      full_ipa = ''
      standard_entry.split_sentence.each do |entry|
        ipa_entry = @phn_manager.phonetic_entry(entry)
        ipa_entry = request_lower_and_capitalize(entry) if ipa_entry.nil?
        return NONE if ipa_entry.nil? || ipa_entry == ''
        full_ipa << ipa_entry + ' '
      end
      full_ipa.strip
    end

    def request_lower_and_capitalize(entry)
      ipa_entry = request(entry)
      ipa_entry = request(entry.capitalize) if ipa_entry.nil?
      return nil if ipa_entry.nil?
      ipa_entry
    end

    def request(standard_entry)
      response = scrape(standard_entry)
      candidates = sift_response(response)
      return nil if candidates.empty?
      select_entry(candidates)
    end

    # Retrieves the html in print mode from wiktionary given an entry and lang_code
    def scrape(entry)
      uri = URI.encode("https://#{@lang_code}.wiktionary.org/w/index.php?title=#{entry}&printable=yes".strip)
      HTTParty.get(uri)
    end

    # Applies all regular expressions to a html response
    def sift_response(response)
      raise Invalid, 'No regexs found for phonetic_script!' if @regexes.empty?
      slash_scan = []
      @regexes.each { |regex| slash_scan << response.scan(/#{regex}/) }
      slash_scan
    end

    # Strips the given word array to see if there is a valid entry
    def select_entry(candidates)
      winner = nil
      candidates.flatten.each do |element|
        break if (winner = element).match(/[0-9]/).nil?
      end
      return nil if winner.nil? || winner == '…'
      winner.gsub(%r{(\/|\(|\)|\*)}, '')
    end
  end
end

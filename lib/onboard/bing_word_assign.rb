require 'bing_translator'

module BingWordAssign
  def self.assign_assocs(associate_pair)
    standard_script, associate_script = associate_pair
    BulkBingHelper.new(standard_script, associate_script).assign_all
  end

  def self.create_metadatum(standard_script, lang_code)
    source = Source.find_or_create_by(name: BING)
    standard_script.meta_data.create(source: source, entry: { lang_code: lang_code })
  end

  class BulkBingHelper
    def initialize(standard_script, associate_script)
      source = Source.find_or_create_by(name: BING)
      @checker = AssociateWordHelper.new(standard_script, associate_script, source)
      @std_lang_code = standard_script.meta_data.find_by(source: source).entry[:lang_code]
      @assoc_lang_code = associate_script.meta_data.find_by(source: source).entry[:lang_code]
      @processor = WordPairProcessor.new(standard_script, associate_script, source)
    end

    BUNDLE_SIZE = 100

    def assign_all
      process_bundles
    end

    private

    def process_bundles
      entries = []
      loop do
        break if @checker.empty?
        std_bundle = @checker.bundle(BUNDLE_SIZE)
        std_entry_bundle = std_bundle.map(&:entry)
        asc_bundle = std_entry_bundle.translate(@std_lang_code, @assoc_lang_code)
        asc_bundle.each { |asc_entry| entries << [std_entry_bundle.shift, asc_entry] }
      end
      @processor.process(entries)
    end
  end

  class AssociateWordHelper
    def initialize(standard_script, associate_script, source)
      all_ids = standard_script.words.pluck(:id)
      std_bing_wa_ids = retrieve_wa_ids(standard_script, source)
      ass_bing_wa_ids = retrieve_wa_ids(associate_script, source)
      word_assocs = WordAssociate.find(std_bing_wa_ids & ass_bing_wa_ids)
      bing_ids = word_assocs.pluck(:associate_a_id, :associate_b_id).flatten
      words = Word.find(all_ids - bing_ids)
      @words_to_check = words & standard_script.words_with_phonetics
    end

    def bundle(size)
      @words_to_check.shift(size)
    end

    def empty?
      @words_to_check.empty?
    end

    private

    def retrieve_wa_ids(script, source)
      bs = script.word_a_meta_data.where(source: source).pluck(:contentable_id)
      as = script.word_b_meta_data.where(source: source).pluck(:contentable_id)
      as | bs
    end
  end
end

# Extends the String class so that a word can be transalted from a 'base'
# language to any other 'target' languages in the bing library.
# https://msdn.microsoft.com/en-us/library/hh456380.aspx
class String
  def translate(base_code, target_code)
    translator = BingTranslator.new(COGNITIVE_SUBSCRIPTION_KEY)
    translator.translate(self, from: base_code, to: target_code)
  end
end

# Extends the Array class so that each element String can be transalted from a
# 'base' language to any other 'target' languages in the bing library.
# https://msdn.microsoft.com/en-us/library/hh456380.aspx
class Array
  def translate(base_code, target_code)
    translator = BingTranslator.new(COGNITIVE_SUBSCRIPTION_KEY)
    translator.translate_array(self, from: base_code, to: target_code)
  end
end

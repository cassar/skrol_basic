require 'bing_translator'

module BingWordAssign
  def self.assign_assocs(associate_pair)
    standard_script, associate_script = associate_pair
    BulkBingHelper.new(standard_script, associate_script).assign_all
  end

  def self.create_metadatum(standard_script, lang_code)
    standard_script.meta_data.create(source: BING, entry: { lang_code: lang_code })
  end

  class BulkBingHelper
    def initialize(standard_script, associate_script)
      @checker = AssociateWordChecker.new(standard_script, associate_script, BING)
      @std_lang_code = standard_script.meta_data.find_by(source: BING).entry[:lang_code]
      @assoc_lang_code = associate_script.meta_data.find_by(source: BING).entry[:lang_code]
      @assoc_word_updater = AssociateWordUpdater.new(associate_script, BING)
    end

    BUNDLE_SIZE = 100

    def assign_all
      process_bundles
    end

    private

    def process_bundles
      loop do
        return if @checker.empty?
        std_bundle = @checker.bundle(BUNDLE_SIZE)
        std_entry_bundle = std_bundle.map(&:entry)
        asc_bundle = std_entry_bundle.translate(@std_lang_code, @assoc_lang_code)
        asc_bundle.each do |asc_entry|
          @assoc_word_updater.update(asc_entry, std_bundle.shift)
        end
      end
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

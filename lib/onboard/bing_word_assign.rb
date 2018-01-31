require 'bing_translator'

module BingWordAssign
  def self.assign_assocs(standard_script, associate_script, bundle_size = 500)
    helper = BulkBingHelper.new(standard_script, associate_script)
    helper.assign_all(bundle_size)
  end

  def self.create_metadatum(standard_script, lang_code)
    source = Source.find_or_create_by(name: BING)
    standard_script.meta_data.create(source: source,
                                     entry: { lang_code: lang_code })
  end

  class BulkBingHelper
    def initialize(standard_script, associate_script)
      source = Source.find_or_create_by(name: BING)
      @checker = AssociateWordHelper.new(standard_script, associate_script, source)
      @std_lang_code = standard_script.meta_data.find_by(source: source).entry[:lang_code]
      @assoc_lang_code = associate_script.meta_data.find_by(source: source).entry[:lang_code]
      @processor = WordPairProcessor.new(standard_script, associate_script, source)
    end

    def assign_all(bundle_size)
      loop do
        break if @checker.empty?
        std_bundle = @checker.bundle(bundle_size).map!(&:entry)
        asc_bundle = std_bundle.translate(@std_lang_code, @assoc_lang_code)
        asc_bundle.map!(&:to_s)
        entries = []
        asc_bundle.each { |asc_entry| entries << [std_bundle.shift, asc_entry] }
        @processor.process(entries)
      end
    end

    class AssociateWordHelper
      def initialize(standard_script, associate_script, source)
        unchecked_words = retrieve_unchecked(standard_script, associate_script, source)
        phonetic_words = standard_script.words_with_phonetics
        sentence_words = retrieve_sentence_words(standard_script, associate_script)
        @words_to_check = unchecked_words & phonetic_words & sentence_words
        puts "words to check: #{@words_to_check.count}"
      end

      def bundle(size)
        @words_to_check.shift(size)
      end

      def empty?
        @words_to_check.empty?
      end

      private

      def retrieve_unchecked(standard_script, associate_script, source)
        std_bing_wa_ids = retrieve_wa_ids(standard_script, source)
        ass_bing_wa_ids = retrieve_wa_ids(associate_script, source)
        word_assocs = WordAssociate.find(std_bing_wa_ids & ass_bing_wa_ids)
        bing_ids = word_assocs.pluck(:associate_a_id, :associate_b_id).flatten
        all_ids = standard_script.words.pluck(:id)
        Word.find(all_ids - bing_ids)
      end

      def retrieve_sentence_words(standard_script, associate_script)
        sentence_associates = standard_script.sentence_associates(associate_script)
        all_sentence_ids = SentenceAssociate.find(sentence_associates.map!(&:id)).pluck(:associate_a_id, :associate_b_id).flatten
        relevant_sentence_ids = all_sentence_ids & standard_script.sentences.pluck(:id)
        word_ids = SentencesWord.where(sentence_id: relevant_sentence_ids).pluck(:word_id).uniq
        Word.find(word_ids)
      end

      def retrieve_wa_ids(script, source)
        bs = script.word_a_meta_data.where(source: source).pluck(:contentable_id)
        as = script.word_b_meta_data.where(source: source).pluck(:contentable_id)
        as | bs
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

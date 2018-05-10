module BingSentenceTranslate
  def self.translate_available(script_from, script_to, batch_size = 100)
    SentenceTranslateHelper.new(script_from, script_to, batch_size).translate_all
  end

  class SentenceTranslateHelper
    def initialize(script_from, script_to, batch_size)
      source = Source.find_or_create_by(name: BING)
      @script_from = script_from
      @batch_size = batch_size
      @from_lang_code = script_from.meta_data.find_by(source: source).entry[:lang_code]
      @to_lang_code = script_to.meta_data.find_by(source: source).entry[:lang_code]
      @assoc_manager = SentenceAssociateManager.new([script_from, script_to])
      @sent_processor = SentencePairProcessor.new(script_from, script_to, source)
    end

    def translate_all
      from_strings = compile_from_strings(@script_from.sentences)
      from_strings.in_groups_of(@batch_size) do |from_group|
        to_group = from_group.translate(@from_lang_code, @to_lang_code)
        from_group.each_index do |index|
          @sent_processor.process_pair(from_group[index], to_group[index])
        end
      end
      puts @sent_processor.report
    end

    private

    def compile_from_strings(sentences)
      from_strings = []
      sentences.each do |sentence|
        next unless @assoc_manager.associates(sentence).empty?
        from_strings << sentence.entry
      end
      from_strings
    end
  end
end

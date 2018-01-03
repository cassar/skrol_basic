class SentenceEntryProcessor
  def initialize(standard_script, source)
    @source = source
    @sentences = standard_script.sentences
    @entry_to_sentence = derive_entry_to_record(@sentences)
    @meta_manager = MetaDataManager.new(source, standard_script.sentence_meta_data)
  end

  def process(sentence_entry, meta_entry = nil)
    return sentence unless (sentence = @entry_to_sentence[sentence_entry]).nil?
    sentence = @sentences.create(entry: sentence_entry)
    return report(sentence_entry) unless sentence.persisted?
    @entry_to_sentence[sentence_entry] = sentence
    @meta_manager.process(sentence, meta_entry)
    sentence
  end

  private

  def report(sentence_entry)
    open('lib/onboard/sentence_entry_processor_log.out', 'a') do |file|
      file.puts "sentence_entry: '#{sentence_entry}' did not save"
    end
    nil
  end
end

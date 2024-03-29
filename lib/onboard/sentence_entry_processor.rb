class SentenceEntryProcessor
  def initialize(standard_script, source)
    @script = standard_script
    @source = source
    @sentences = standard_script.sentences
    @entry_to_sentence = derive_entry_to_record(@sentences)
    @meta_manager = MetaDataProcessor.new(standard_script.sentence_meta_data, source, 'Sentence')
    @created_count = 0
    @errors = "The following sentences for source: '#{source.name}' failed to save:\n"
  end

  def process(sentence_entry)
    sentence = @entry_to_sentence[sentence_entry]
    sentence = create(sentence_entry) if sentence.nil?
    @meta_manager.process(sentence) unless sentence.nil?
    sentence
  end

  def report
    report = "#{@created_count} Sentences created for '#{@script.name}'.\n"
    report << @errors
    report << @meta_manager.report
    report << "\n"
  end

  private

  def create(sentence_entry)
    sentence = @sentences.create(entry: sentence_entry)
    if sentence.persisted?
      @entry_to_sentence[sentence_entry] = sentence
      @created_count += 1
      return sentence
    else
      @errors << "entry: '#{sentence_entry}'"
      return nil
    end
  end
end

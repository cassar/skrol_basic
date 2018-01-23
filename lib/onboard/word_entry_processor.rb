class WordEntryProcessor
  def initialize(script, source, words = nil)
    @script = script
    words = script.words if words.nil?
    @meta_processor = MetaDataProcessor.new(script.word_meta_data, source, 'Word')
    @entry_to_word = derive_entry_to_record(words)
    @created_count = 0
    @errors = "Word entries not saved:\n"
  end

  def process(word_entry)
    standard_candidate = word_entry.downcase
    word = @entry_to_word[standard_candidate]
    word = new_word(standard_candidate) if word.nil?
    @meta_processor.process(word) unless word.nil?
    word
  end

  def report
    report = "#{@created_count} words created for #{@script.name}\n#{@errors}"
    report << @meta_processor.report
    report << "\n"
  end

  private

  def new_word(standard_candidate)
    word = @script.words.create(entry: standard_candidate)
    if word.persisted?
      @entry_to_word[standard_candidate] = word
      @created_count += 1
      return word
    else
      @errors << "'#{standard_candidate}'\n"
      return nil
    end
  end
end

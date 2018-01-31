class WordPairProcessor
  def initialize(script1, script2, source)
    @entry_processor1 = WordEntryProcessor.new(script1, source)
    @entry_processor2 = WordEntryProcessor.new(script2, source)
    @processor = if script1.language_id == script2.language_id
                   WordPhoneticProcessor.new(script1, script2, source)
                 else
                   WordAssociateProcessor.new(script1, script2, source)
                 end
  end

  attr_reader :entry_processor1

  def process(entries)
    entries.each do |entry1, entry2|
      word1, word2 = process_entries(entry1, entry2)
      next if word1.nil? || word2.nil?
      @processor.process(word1, word2)
    end
    report
  end

  private

  def process_entries(entry1, entry2)
    word1 = @entry_processor1.process(entry1)
    word2 = @entry_processor2.process(entry2)
    [word1, word2]
  end

  def report
    report = @entry_processor1.report
    report << @entry_processor2.report
    report << @processor.report
    report << "\n"
  end
end

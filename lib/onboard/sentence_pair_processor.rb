class SentencePairProcessor
  def initialize(standard_script1, standard_script2, source)
    @standard_script1 = standard_script1
    @standard_script2 = standard_script2
    @entry_processor1 = SentenceEntryProcessor.new(standard_script1, source)
    @entry_processor2 = SentenceEntryProcessor.new(standard_script2, source)
    @sent_assoc_manager = SentenceAssociateProcessor.new(standard_script1, standard_script2, source)
  end

  def process(entries)
    entries.each do |entry1, entry2|
      sentence1 = @entry_processor1.process(entry1)
      sentence2 = @entry_processor2.process(entry2)
      @sent_assoc_manager.process(sentence1, sentence2)
    end
    puts report
  end

  private

  def report
    report = @entry_processor1.report
    report << @entry_processor2.report
    report << @sent_assoc_manager.report
    report << "\n"
  end
end

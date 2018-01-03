class SentencePairProcessor
  def initialize(standard_script1, standard_script2, source)
    @entry_processor1 = SentenceEntryProcessor.new(standard_script1, source)
    @entry_processor2 = SentenceEntryProcessor.new(standard_script2, source)
    @sent_assoc_manager = SentenceAssociateManager.new([standard_script1, standard_script2])
  end

  def process(sentence_entry1, meta_entry1, sentence_entry2, meta_entry2)
    sentence1 = @entry_processor1.process(sentence_entry1, meta_entry1)
    sentence2 = @entry_processor2.process(sentence_entry2, meta_entry2)
    @sent_assoc_manager.pair!(sentence1, sentence2)
  end
end

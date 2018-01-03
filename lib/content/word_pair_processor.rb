class WordPairProcessor
  def initialize(language, source)
    std_script = language.standard_script
    std_words = std_script.words
    @std_entry_processor = WordEntryProcessor.new(std_script, source, std_words)
    @phn_entry_processor = WordEntryProcessor.new(language.phonetic_script, source)
    @wrd_phonetic_processor = WordPhoneticManager.new(std_script, source, std_words)
  end

  def process(entries)
    entries.each { |std_entry, phn_entry| process_entries(std_entry, phn_entry) }
    report
  end

  private

  def process_entries(std_entry, phn_entry)
    std_word = @std_entry_processor.process(std_entry)
    phn_word = @phn_entry_processor.process(phn_entry)
    @wrd_phonetic_processor.add(std_word, phn_word)
  end

  def report
    std_count = @std_entry_processor.created_count
    phn_count = @phn_entry_processor.created_count
    assoc_count = @wrd_phonetic_processor.created_count
    "std words created: #{std_count}, phn words: #{phn_count}, word associates: #{assoc_count}"
  end
end

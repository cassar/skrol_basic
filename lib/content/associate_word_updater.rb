class AssociateWordUpdater
  def initialize(associate_script, source)
    assoc_words = associate_script.words
    @assoc_word_entry_processor = WordEntryProcessor.new(associate_script, source)
    @assoc_word_phonetic_manager = WordPhoneticManager.new(associate_script, assoc_words)
  end

  def update(assoc_entry, std_word)
    assoc_word = @assoc_word_entry_processor.process(assoc_entry)
    return if assoc_word.nil?
    @assoc_word_phonetic_manager.check(assoc_word)
    std_word.associate_bs << assoc_word
  end
end

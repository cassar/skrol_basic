class PhoneticWordUpdater
  def initialize(phonetic_script, source)
    @words_to_check = Queue.new
    check_phonetic.standards.each { |word| @words_to_check << word }
    @phn_entry_processor = WordEntryProcessor.new(phonetic_script, source)
    @phn_none_word = SentinalManager.retrieve(phonetic_script)
  end

  def update(std_word, phon_entry)
    std_word.phonetics.clear
    phon_word = @phn_entry_processor.process(phon_entry)
    return if phon_word.nil?
    WordPhonetic.where(standard: std_word, phonetic: @phn_none_word)
    std_word.phonetics << phon_word
  end

  def next_word
    @words_to_check.shift
  end
end

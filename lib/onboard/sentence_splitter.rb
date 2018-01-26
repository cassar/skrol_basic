class SentenceSplitter
  def initialize(standard_script)
    @standard_script = standard_script
    source = Source.find_or_create_by(name: SENTENCE_SPLITTER)
    @word_entry_processor = WordEntryProcessor.new(standard_script, source)
    @word_phn_checker = WordPhoneticChecker.new(standard_script)
  end

  def process(standard_sentence)
    standard_sentence.entry.split_sentence.each do |word_entry|
      next if word_entry == ''
      std_word = @word_entry_processor.process(word_entry)
      next if std_word.nil?
      @word_phn_checker.check(std_word)
    end
  end

  def process_all
    @standard_script.sentences.each { |sentence| process(sentence) }
    puts @word_entry_processor.report
  end
end

# Split sentence into words removing any punctuation
class String
  def split_sentence
    remove_sentence_deliniators.split(%r{\s|\'|\-})
  end

  def remove_sentence_deliniators
    gsub(%r{\.|\!|\?|\:|\,|\;|\¿|\¡|\(|\)|\"}, '')
  end
end

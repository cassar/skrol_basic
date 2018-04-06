class SentenceSplitter
  def initialize(standard_script)
    @standard_script = standard_script
    source = Source.find_or_create_by(name: SENTENCE_SPLITTER)
    @word_entry_processor = WordEntryProcessor.new(standard_script, source)
  end

  def process(standard_sentence)
    standard_sentence.entry.split_sentence.each do |word_entry|
      next if word_entry == ''
      @word_entry_processor.process(word_entry)
    end
  end

  def process_all(corr_script = nil)
    if corr_script.nil?
      @standard_script.sentences.each { |sentence| process(sentence) }
    else
      sentences = corr_script.associate_sentences(@standard_script)
      sentences.each { |sentence| process(sentence) }
    end
    puts @word_entry_processor.report
  end
end

# Split sentence into words removing any punctuation
class String
  @@sentence_deliniators = %r{\.|\!|\?|\:|\,|\;|\¿|\¡|\(|\)|\"}
  @@word_deliniators = %r{\s|\'|\-}

  def split_sentence
    remove_sentence_deliniators.split(@@word_deliniators)
  end

  def remove_sentence_deliniators
    gsub(@@sentence_deliniators, '')
  end

  def contains_deliniator?
    combined = Regexp.union(@@word_deliniators, @@sentence_deliniators)
    return true if match(combined)
    false
  end
end

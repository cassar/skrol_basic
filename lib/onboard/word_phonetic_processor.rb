class WordPhoneticProcessor
  def initialize(standard_script, source)
    @source = source
    @created_count = 0
    @errors = "WordPhonetic record processing errors:\n"
    @meta_processor = MetaDataProcessor.new(standard_script.word_phon_meta_data, source, 'WordPhonetic')
  end

  def process(std_word, phn_word)
    word_phon = WordPhonetic.find_or_initialize_by(standard: std_word,
                                                   phonetic: phn_word)
    return word_phon if word_phon.persisted?
    save_word_phon(word_phon)
  end

  def report
    report = "#{@created_count} WordPhonetic Records created "
    report << "from source #{@source.name}\n"
    report << @errors
    report << @meta_processor.report
  end

  private

  def save_word_phon(word_phon)
    if word_phon.save
      @created_count += 1
      @meta_processor.process(word_phon)
      word_phon
    else
      @errors << "WordPhonetics std_word: #{std_word.id}, phn_word: #{phn_word.id}"
      nil
    end
  end
end

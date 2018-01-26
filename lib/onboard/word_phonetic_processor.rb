class WordPhoneticProcessor
  def initialize(standard_script, phonetic_script, source)
    @none_word = phonetic_script.words.find_or_create_by(entry: NONE)
    @source = source
    @created_count = 0
    @errors = "WordPhonetic record processing errors:\n"
    @meta_processor = MetaDataProcessor.new(standard_script.word_phon_meta_data, source, 'WordPhonetic')
  end

  def process(std_word, phn_word)
    word_phon = WordPhonetic.find_by(standard: std_word, phonetic: @none_word)
    if word_phon.present?
      word_phon.update(phonetic: phn_word)
    else
      word_phon = WordPhonetic.find_or_create_by(standard: std_word,
                                                 phonetic: phn_word)
    end
    return if word_phon.nil?
    @created_count += 1
    @meta_processor.process(word_phon)
  end

  def report
    report = "#{@created_count} WordPhonetic Records created "
    report << "from source #{@source.name}\n"
    report << @errors
    report << @meta_processor.report
  end
end

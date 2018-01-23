class WordPhoneticProcessor
  def initialize(standard_script, source, std_words = nil)
    checker = WordPhoneticChecker.new(standard_script, std_words)
    @std_word_to_word_phons = checker.std_word_to_word_phons
    @phn_none_word = checker.phn_none_word
    @source = source
    @created_count = 0
    @errors = "WordPhonetic record processing errors:\n"
    @meta_processor = MetaDataProcessor.new(standard_script.word_phonetic_meta_data, source, 'WordPhonetic')
  end

  def process(std_word, phn_word)
    word_phon = nil
    word_phons = @std_word_to_word_phons[std_word]
    word_phon = retrieve(word_phons, phn_word) if word_phons.present?
    word_phon = create if word_phons.nil?
    @meta_processor.process(word_phon) unless word_phon.nil?
  end

  def report
    report = "#{@created_count} WordPhonetic Records created "
    report << "from source #{@source}\n"
    report << @errors
  end

  private

  def retrieve(word_phons, phn_word)
    word_phons.each do |wp|
      return wp if [phn_word.id, @phn_none_word.id].include? wp.phonetic_id
    end
    nil
  end

  def create(std_word, phn_word)
    word_phon = WordPhonetic.create(standard: std_word, phonetic: phn_word)
    if word_phon.persisted?
      @created_count += 1
      @std_word_to_word_phons[std_word] = [word_phon]
    else
      @errors << "std_word_id: #{std_word.id}, phn_word_id: #{phn_word}\n"
      return nil
    end
    word_phon
  end
end

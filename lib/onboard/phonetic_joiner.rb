class PhoneticJoiner
  def initialize(standard_script, phonetic_script)
    @phonetic_script = phonetic_script
    source = Source.find_or_create_by(name: 'Phonetic Joiner')
    @pair_processor = WordPairProcessor.new(standard_script, phonetic_script, source)
    @std_processor = @pair_processor.entry_processor1
    @entries = []
  end

  def join_all
    none = @phonetic_script.words.find_or_create_by(entry: NONE)
    none.standards.each { |word| join(word.entry) }
    puts @pair_processor.process(@entries)
  end

  private

  def join(std_entry)
    return if (word_arr = std_entry.split_sentence).length < 2
    phn_entry = ''
    word_arr.each do |entry|
      std_word = @std_processor.process(entry)
      return nil if std_word.nil? || (phn_word = std_word.phonetics.first).nil?
      phn_entry << phn_word.entry + ' '
    end
    @entries << [std_entry, phn_entry.strip]
  end
end

class IntegrityManager
  def initialize(standard_script, phonetic_script)
    @standard_script = standard_script
    @phonetic_script = phonetic_script
  end

  def enforce
    remove_all_duplicates
    phonetic_links
    nil
  end

  private

  def remove_all_duplicates
    remove_duplicates(@standard_script.sentences)
    remove_duplicates(@standard_script.words)
    remove_duplicates(@phonetic_script.words)
  end

  def remove_duplicates(records)
    entry_to_records = derive_entry_to_records(records)
    entry_to_records.each do |entry, sub_records|
      next if sub_records.count < 2
      puts "duplicate_entry: '#{entry}', #{sub_records.count} found."
      record = sub_records.first
      sub_records.each { |dup| dup.destroy unless dup == record }
    end
  end

  def phonetic_links
    std_word_to_phons = derive_std_word_to_phons(@standard_script, @phonetic_script)
    phn_none_word = SentinalManager.retrieve(@phonetic_script)
    @standard_script.words.each do |word|
      examine_phons(std_word_to_phons[word], word, phn_none_word)
    end
  end

  def examine_phons(phons, word, phn_none_word)
    if phons.nil?
      word.phonetics << phn_none_word
    else
      return unless phons.include?(phn_none_word) && phons.length > 1
      WordPhonetic.where(standard: word, phonetic: phn_none_word).destroy_all
    end
  end

  def derive_std_word_to_phons(standard_script, phonetic_script)
    std_words = standard_script.words
    phn_words = phonetic_script.words
    word_phonetics = standard_script.phonetic_word_phonetics
    derive_std_record_to_phn_records(std_words, phn_words, word_phonetics)
  end
end

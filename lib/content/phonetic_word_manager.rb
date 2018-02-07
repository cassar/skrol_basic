class PhoneticWordManager
  def initialize(standard_script, phonetic_script)
    @std_word_to_phons = derive_std_word_to_phons(standard_script, phonetic_script)
    @std_entry_to_phon_entry = {}
    @std_word_to_phons.each do |std, phns|
      @std_entry_to_phon_entry[std.entry] = phns.first.entry
    end
  end

  def first_phonetic(standard_word)
    @std_word_to_phons[standard_word].first
  rescue StandardError
    puts "standard_word: '#{standard_word.entry}' has no phonetic"
  end

  def phonetic_entry(standard_entry)
    @std_entry_to_phon_entry[standard_entry]
  end

  private

  def derive_std_word_to_phons(standard_script, phonetic_script)
    std_words = standard_script.words_with_phonetics
    phn_words = phonetic_script.words
    word_phonetics = standard_script.phonetic_word_phonetics
    derive_std_record_to_phn_records(std_words, phn_words, word_phonetics)
  end
end

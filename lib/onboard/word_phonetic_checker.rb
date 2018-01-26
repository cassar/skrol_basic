class WordPhoneticChecker
  def initialize(standard_script, std_words = nil)
    word_phonetics = standard_script.phonetic_word_phonetics
    std_words = standard_script.words if std_words.nil?
    @std_word_to_word_phons = derive_std_rec_to_rec_phons(std_words, word_phonetics)
    @phn_none_word = SentinalManager.retrieve(standard_script.phonetic)
  end

  attr_reader :std_word_to_word_phons
  attr_reader :phn_none_word

  def check(std_word)
    word_phons = @std_word_to_word_phons[std_word]
    return word_phons unless word_phons.nil?
    word_phon = WordPhonetic.create(standard: std_word, phonetic: @phn_none_word)
    @std_word_to_word_phons[std_word] = [word_phon]
  end
end

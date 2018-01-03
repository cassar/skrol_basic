class WordPhoneticManager
  def initialize(standard_script, source, std_words = nil)
    word_phonetics = standard_script.phonetic_word_phonetics
    std_words = standard_script if std_words.nil?
    @std_word_to_word_phons = derive_std_rec_to_rec_phons(std_words, word_phonetics)
    @phn_none_word = SentinalManager.retrieve(standard_script.phonetic)
    @source = source
    @created_count = 0
  end

  attr_reader :created_count

  def check(std_word)
    word_phons = @std_word_to_word_phons[std_word]
    return word_phons unless word_phons.nil?
    word_phon = WordPhonetic.create(standard: std_word, phonetic: @phn_none_word)
    @std_word_to_word_phons[std_word] = [word_phon]
  end

  def add(std_word, phn_word)
    word_phons = @std_word_to_word_phons[std_word]
    word_phons = [] if word_phons.nil?
    word_phons.each { |wp| return wp if wp.phonetic_id == phn_word.id }
    word_phon = WordPhonetic.create(standard: std_word, phonetic: phn_word)
    word_phon.meta_data.create(source: @source)
    @created_count += 1
    @std_word_to_word_phons[std_word] = word_phons << word_phon
  end
end

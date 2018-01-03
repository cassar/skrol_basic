class StandardWordChecker
  def initialize(standard_script, associate_script = nil)
    @standard_script = standard_script
    @std_words = @standard_script.words
    @word_phonetic_manager = WordPhoneticManager.new(@standard_script, @std_words)
    return unless associate_script.present?
    @assoc_word_checker = AssociateWordChecker.new(@standard_script, associate_script, @std_words)
  end

  def check(standard_word)
    @word_phonetic_manager.check(standard_word)
    @assoc_word_checker.check(standard_word) unless @assoc_word_checker.nil?
    standard_word
  end

  def sentence_word_linked
    @standard_script.sentence_linked_words.each { |word| check(word) }
  end
end

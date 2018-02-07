class SuitableAssociateCompiler
  def initialize(lang_map)
    @script1 = lang_map.base_language.standard_script
    @script2 = lang_map.target_language.standard_script
    @word_assoc_rep_compiler = WordAssociateRepresentationCompiler.new([@script1, @script2])
    word_assoc_manager = @word_assoc_rep_compiler.word_assoc_manager
    suitable_words = @script1.words_with_phonetics | @script2.words_with_phonetics
    @suitable_word_associates = word_assoc_manager.suitable_word_associates(suitable_words)
    @sent_assoc_manager = @word_assoc_rep_compiler.sent_assoc_manager
  end

  def compile
    @sent_assoc_manager.sent_assocs.each do |sent_assoc|
      next if sentences_too_long?(sent_assoc)
      assoc_rep1, assoc_rep2 = @word_assoc_rep_compiler.compile(sent_assoc)
      next if contains_unsuitable_word_assocs?(sent_assoc, assoc_rep1, assoc_rep2)
      @sent_assoc_manager.check_word_associate_representation(sent_assoc, assoc_rep1, assoc_rep2)
    end
  end

  private

  def sentences_too_long?(sent_assoc)
    return false unless @sent_assoc_manager.sentences_too_long?(sent_assoc)
    clear_representations(sent_assoc)
    true
  end

  def contains_unsuitable_word_assocs?(sent_assoc, assoc_rep1, assoc_rep2)
    if ((assoc_rep1 | assoc_rep2) - @suitable_word_associates).present?
      clear_representations(sent_assoc)
      return true
    end
    false
  end

  def clear_representations(sent_assoc)
    return if sent_assoc.representations.nil?
    sent_assoc.update(representations: nil)
  end
end

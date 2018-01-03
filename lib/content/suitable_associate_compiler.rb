class SuitableAssociateCompiler
  def initialize(associate_scripts)
    @script1, @script2 = associate_scripts
    suitable_words = @script1.words_with_phonetics | @script2.words_with_phonetics
    @word_assoc_rep_compiler = WordAssociateRepresentationCompiler.new(associate_scripts)
    word_assoc_manager = @word_assoc_rep_compiler.word_assoc_manager
    @suitable_word_associates = word_assoc_manager.suitable_word_associates(suitable_words)
    @sent_assoc_manager = @word_assoc_rep_compiler.sent_assoc_manager
  end

  def compile
    @sent_assoc_manager.sent_assocs.each do |sent_assoc|
      next if @sent_assoc_manager.sentences_too_long?(sent_assoc)
      assoc_rep1, assoc_rep2 = @word_assoc_rep_compiler.compile(sent_assoc)
      next if ((assoc_rep1 | assoc_rep2) - @suitable_word_associates).present?
      @sent_assoc_manager.check_word_associate_representation(sent_assoc, assoc_rep1, assoc_rep2)
    end
  end
end

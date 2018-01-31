class SlideConstructor
  def initialize(enrolment_manager, target_sentence)
    @enrolment = enrolment_manager.enrolment
    @enrolment_manager = enrolment_manager
    @target_sentence = target_sentence
    @target_script, @base_script = enrolment_manager.associated_scripts
    @word_manager = WordAndAssociateManager.new(@target_sentence, enrolment_manager)
    @phn_sent_deriver = PhoneticSentenceDeriver.new(@target_script)
    @html_constructor = HTMLConstructor.new(enrolment_manager, @word_manager)
  end

  def construct
    assign_word_scores
    content = compile_content
    slide = @html_constructor.compile_sentences_tag(content)
    { slide: slide, metrics: @html_constructor.user_metric_ids, service: 'GOOD',
      phn_chars: @html_constructor.phn_chars.uniq }
  end

  private

  def assign_word_scores
    @word_manager.target_assoc_rep.each do |assoc|
      word = @word_manager.word(assoc, @target_script)
      @enrolment_manager.assign_status(word, TESTING)
    end
  end

  def compile_content
    target_html_rep = construct_standard_html_rep(@target_script, 'target')
    base_html_rep = construct_standard_html_rep(@base_script, 'base')
    phonetic_html_rep = construct_phonetic_html_rep
    target_html_rep + phonetic_html_rep + base_html_rep
  end

  def construct_standard_html_rep(script, type)
    inner_html_rep = @html_constructor.standard_inner_rep(script)
    @html_constructor.compile_sentence_tag(inner_html_rep, type)
  end

  def construct_phonetic_html_rep
    target_assoc_rep = @word_manager.target_assoc_rep
    target_phn_rep = @phn_sent_deriver.phonetic_representation(target_assoc_rep)
    phonetic_inner_html_rep = @html_constructor.phonetic_inner_rep(target_assoc_rep, target_phn_rep)
    @html_constructor.compile_sentence_tag(phonetic_inner_html_rep, 'phonetic')
  end
end

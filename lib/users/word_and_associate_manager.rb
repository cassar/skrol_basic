class WordAndAssociateManager
  def initialize(target_sentence, enrolment_manager)
    @target_sentence = target_sentence
    @target_script, @base_script = enrolment_manager.associated_scripts
    sentence_associate, @base_sentence =
      target_sentence.associate_and_corresponding(@base_script)
    @target_assoc_rep = sentence_associate.word_associates(@target_sentence)
    @base_assoc_rep = sentence_associate.word_associates(@base_sentence)
    retrieve_words
  end

  attr_reader :target_assoc_rep
  attr_reader :target_script
  attr_reader :target_sentence

  def assoc_rep_and_sentence(script)
    return [@target_assoc_rep, @target_sentence] if script == @target_script
    [@base_assoc_rep, @base_sentence]
  end

  def word(associate, script)
    return @word_associate_to_base_word[associate] if script == @base_script
    @word_associate_to_target_word[associate]
  end

  private

  def retrieve_words
    word_ids = []
    (word_assocs = @target_assoc_rep | @base_assoc_rep).each do |wa|
      word_ids << wa.associate_a_id
      word_ids << wa.associate_b_id
    end
    organise_words(Word.find(word_ids.uniq), word_assocs)
  end

  def organise_words(words, word_assocs)
    word_id_to_word = derive_record_id_to_record(words)
    @word_associate_to_target_word = {}
    @word_associate_to_base_word = {}
    word_assocs.each do |wa|
      retrieve_and_assign(wa, word_id_to_word)
    end
  end

  def retrieve_and_assign(wa, word_id_to_word)
    word_a = word_id_to_word[wa.associate_a_id]
    word_b = word_id_to_word[wa.associate_b_id]
    if word_a.script_id == @base_script.id
      assign_to_hash(wa, word_a, word_b)
    else
      assign_to_hash(wa, word_b, word_a)
    end
  end

  def assign_to_hash(wa, base_word, target_word)
    @word_associate_to_base_word[wa] = base_word
    @word_associate_to_target_word[wa] = target_word
  end
end

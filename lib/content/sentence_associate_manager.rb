class SentenceAssociateManager
  def initialize(associate_scripts)
    @script1, @script2 = associate_scripts
    @sent_id_to_sent1 = derive_record_id_to_record(@script1.sentences)
    @sent_id_to_sent2 = derive_record_id_to_record(@script2.sentences)
    @sent_assocs = @script1.sentence_associates(@script2)
    @sent_to_assocs = derive_record_to_assocs(@script1.sentences | @script2.sentences, sent_assocs)
  end

  attr_reader :sent_assocs
  attr_reader :sent_to_assocs

  def sentences(sentence_associate)
    sent1 = @sent_id_to_sent1[sentence_associate.associate_a_id]
    sent1 = @sent_id_to_sent1[sentence_associate.associate_b_id] if sent1.nil?
    sent2 = @sent_id_to_sent2[sentence_associate.associate_a_id]
    sent2 = @sent_id_to_sent2[sentence_associate.associate_b_id] if sent2.nil?
    [sent1, sent2]
  end

  def sentences_too_long?(sentence_associate)
    sent1, sent2 = sentences(sentence_associate)
    return true if sent1.entry.length > MAX_LENGTH_MAP
    return true if sent2.entry.length > MAX_LENGTH_MAP
    false
  end

  def corresponding(sentence, sentence_associate)
    sent1, sent2 = sentences(sentence_associate)
    return sent1 unless sentence == sent1
    sent2
  end

  def associated(script, sent_associate)
    sent1, sent2 = sentences(sent_associate)
    return sent1 if script == @script1
    sent2
  end

  def associates(sentence)
    assocs = @sent_to_assocs[sentence]
    return [] if assocs.nil?
    assocs
  end

  def representation(associate, script)
    rep_a, rep_b = associate.representations
    sent_a = @sent_id_to_sent1[associate.associate_a_id]
    sent_a = @sent_id_to_sent2[associate.associate_a_id] if sent_a.nil?
    return rep_a if sent_a.script_id == script.id
    rep_b
  end

  def check_word_associate_representation(sentence_associate, assoc_rep1, assoc_rep2)
    assoc_rep_ids1 = assoc_rep_to_ids(assoc_rep1)
    assoc_rep_ids2 = assoc_rep_to_ids(assoc_rep2)
    if @sent_id_to_sent1[sentence_associate.associate_a_id].present?
      confirm_representation(sentence_associate, [assoc_rep_ids1, assoc_rep_ids2])
    else
      confirm_representation(sentence_associate, [assoc_rep_ids2, assoc_rep_ids1])
    end
  end

  private

  def confirm_representation(sentence_associate, representations)
    return if sentence_associate.representations == representations
    sentence_associate.update(representations: representations)
  end

  def assoc_rep_to_ids(assoc_rep)
    ids = []
    assoc_rep.each { |assoc| ids << assoc.id }
    ids
  end
end

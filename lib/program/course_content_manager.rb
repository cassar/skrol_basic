class CourseContentManager
  def initialize(lang_map)
    assign_scripts(lang_map)
    check_phonetics
    assign_sentence_and_word_associates
    assign_words
    assign_sentences
  end

  attr_reader :tar_stn_words
  attr_reader :tar_stn_sents
  attr_reader :tar_stn_spt
  attr_reader :sentence_associates

  def standard_words
    [@tar_stn_words, @bse_stn_words]
  end

  def phonetic_words
    [@tar_phn_words, @bse_phn_words]
  end

  def standard_content
    [@tar_stn_words, @tar_stn_sents, @bse_stn_words, @bse_stn_words]
  end

  def standard_scripts
    [@tar_stn_spt, @bse_stn_spt]
  end

  private

  def assign_scripts(lang_map)
    @tar_stn_spt = lang_map.target_script
    @tar_phn_spt = @tar_stn_spt.phonetic
    @bse_stn_spt = lang_map.base_script
    @bse_phn_spt = @bse_stn_spt.phonetic
  end

  def check_phonetics
    IntegrityManager.new(@tar_stn_spt, @tar_phn_spt).enforce
    IntegrityManager.new(@bse_stn_spt, @bse_phn_spt).enforce
  end

  def assign_sentence_and_word_associates
    @sentence_associates = @tar_stn_spt.suitable_sentence_associates(@bse_stn_spt)
    word_assoc_ids = []
    @sent_assoc_manager = SentenceAssociateManager.new([@tar_stn_spt, @bse_stn_spt])
    @sentence_associates.each do |sent_assoc|
      word_assoc_ids << @sent_assoc_manager.representation(sent_assoc, @tar_stn_spt)
    end
    @word_associates = WordAssociate.find(word_assoc_ids.flatten.uniq)
  end

  def assign_words
    @tar_stn_words, @bse_stn_words = retrieve_std_words
    @tar_phn_words = retrieve_phonetics(@tar_stn_spt, @tar_phn_spt, @tar_stn_words)
    @bse_phn_words = retrieve_phonetics(@bse_stn_spt, @bse_phn_spt, @bse_stn_words)
  end

  def retrieve_std_words
    tar_stn_words = []
    bse_stn_words = []
    word_assoc_manager = WordAssociateManager.new([@tar_stn_spt, @bse_stn_spt])
    @word_associates.each do |word_associate|
      tar_word, bse_word = word_assoc_manager.words(word_associate)
      tar_stn_words |= [tar_word]
      bse_stn_words |= [bse_word]
    end
    [tar_stn_words, bse_stn_words]
  end

  def assign_sentences
    @tar_stn_sents = []
    @bse_stn_sents = []
    @sentence_associates.each do |sentence_associate|
      tar_sent, bse_sent = @sent_assoc_manager.sentences(sentence_associate)
      @tar_stn_sents |= [tar_sent]
      @bse_stn_sents |= [bse_sent]
    end
  end

  def retrieve_phonetics(std_spt, phn_spt, std_words)
    phon_word_manager = PhoneticWordManager.new(std_spt, phn_spt)
    phn_words = []
    std_words.each do |std_word|
      phn_words << phon_word_manager.first_phonetic(std_word)
    end
    phn_words
  end
end

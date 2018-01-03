class AssociateWordChecker
  def initialize(standard_script, associate_script, source)
    std_bing_wa_ids = retrieve_wa_ids(standard_script, source)
    asc_bing_was = retrieve_wa_ids(associate_script, source)
    word_associates = WordAssociate.find(std_bing_metas & asc_bing_metas)
    sorter = WordAssociateSorter.new(word_associates, standard_script, associate_script)
    std_words, asc_words = sorter.words
    @words_to_check = standard_script.words_with_phonetics - std_words
  end

  def bundle(size)
    @words_to_check.shift(size)
  end

  def empty?
    @words_to_check.empty?
  end

  private

  def retrieve_wa_ids(script, source)
    bs = script.word_a_meta_data.where(source: source).pluck(:contentable_id)
    as = script.word_b_meta_data.where(source: source).pluck(:contentable_id)
    as | bs
  end
end

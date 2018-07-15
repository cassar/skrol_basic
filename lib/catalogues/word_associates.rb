class WordAssociateSorter
  def initialize(word_assocs, script1, script2)
    @script1 = script1
    @script2 = script2
    @word_assocs = word_assocs
    @words1 = []
    @words2 = []
  end

  def words
    retrieve_words
    [@words1, @words2]
  end

  private

  def retrieve_words
    word_ids = []
    @word_assocs.each do |word_assoc|
      word_ids << word_assoc.associate_a_id
      word_ids << word_assoc.associate_b_id
    end
    organise_words(Word.find(word_ids.uniq))
  end

  def organise_words(words)
    @word_id_to_word = derive_record_id_to_record(words)
    @word_assocs.each { |word_assoc| retrieve_and_assign(word_assoc) }
  end

  def retrieve_and_assign(word_assoc)
    word_a = @word_id_to_word[word_assoc.associate_a_id]
    word_b = @word_id_to_word[word_assoc.associate_b_id]
    if word_a.script_id == @script1.id
      assign_to_hash(word_a, word_b)
    else
      assign_to_hash(word_b, word_a)
    end
  end

  def assign_to_hash(word1, word2)
    @words1 << word1
    @words2 << word2
  end
end

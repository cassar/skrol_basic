class WordAssociateManager
  def initialize(associate_scripts)
    @script1, @script2 = associate_scripts
    words1 = @script1.words
    words2 = @script2.words
    @word_id_to_word1, @word_id_to_word2 = derive_word_id_to_words(words1, words2)
    @word_assocs = @script1.word_associates(@script2)
    @word_to_assocs = derive_record_to_assocs((words1 | words2), @word_assocs)
  end

  attr_reader :word_to_assocs

  def suitable_word_associates(suitable_words)
    word_id_to_word = derive_record_id_to_record(suitable_words)
    suitable_word_associates = []
    @word_assocs.each do |assoc|
      next if word_id_to_word[assoc.associate_a_id].nil?
      next if word_id_to_word[assoc.associate_b_id].nil?
      suitable_word_associates << assoc
    end
    suitable_word_associates
  end

  def words(word_associate)
    word1 = @word_id_to_word1[word_associate.associate_a_id]
    word1 = @word_id_to_word1[word_associate.associate_b_id] if word1.nil?
    word2 = @word_id_to_word2[word_associate.associate_a_id]
    word2 = @word_id_to_word2[word_associate.associate_b_id] if word2.nil?
    [word1, word2]
  end

  def corresponding(word, word_associate)
    word1, word2 = words(word_associate)
    return word1 unless word == word1
    word2
  end

  def associates(word)
    assocs = @word_to_assocs[word]
    return [] if assocs.nil?
    assocs
  end

  def associated(script, word_associate)
    word1, word2 = words(word_associate)
    return word1 if script == @script1
    return word2 if script == @script2
  end

  private

  def derive_word_id_to_words(words1, words2)
    word_id_to_word1 = derive_record_id_to_record(words1)
    word_id_to_word2 = derive_record_id_to_record(words2)
    [word_id_to_word1, word_id_to_word2]
  end
end

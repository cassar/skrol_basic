class WordAssociateProcessor
  def initialize(script1, script2, source)
    @manager = WordAssociateManager.new([script1, script2])
    @word_to_assocs = @manager.word_to_assocs
    metas1 = script1.word_associate_meta_data(source)
    metas2 = script2.word_associate_meta_data(source)
    @meta_processor = MetaDataProcessor.new(metas1 | metas2, source, 'WordAssociate')
    @created_count = 0
    @errors = "Could not save WordAssociate for following pairs '#{script1.name}', '#{script2.name}':\n"
    @source = source
  end

  def process(word1, word2)
    word_assoc = (@manager.associates(word1) | @manager.associates(word2)).first
    word_assoc = create(word1, word2) if word_assoc.nil?
    return if word_assoc.nil?
    @meta_processor.process(word_assoc)
  end

  def report
    report = "#{@created_count} WordAssociate records created"
    report << " from source '#{@source.name}'\n"
    report << @errors
    report << "\n"
  end

  private

  def create(word1, word2)
    word_assoc = WordAssociate.create(associate_a: word1, associate_b: word2)
    if word_assoc.persisted?
      @word_to_assocs[word1] = [word_assoc]
      @word_to_assocs[word2] = [word_assoc]
      @created_count += 1
      return word_assoc
    else
      @errors << "word1: '#{word1.entry}', word2: '#{word2.entry}'"
      return nil
    end
  end
end

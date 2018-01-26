class SentenceAssociateProcessor
  def initialize(script1, script2, source)
    @manager = SentenceAssociateManager.new([script1, script2])
    @sent_to_assocs = @manager.sent_to_assocs
    metas1 = script1.sentence_associate_meta_data(source)
    metas2 = script2.sentence_associate_meta_data(source)
    @meta_processor = MetaDataProcessor.new(metas1 | metas2, source, 'SentenceAssociate')
    @created_count = 0
    @errors = "Could not save SentenceAssociate for following pairs '#{script1.name}', '#{script2.name}':\n"
  end

  def process(sent1, sent2)
    sent_assoc = (@manager.associates(sent1) | @manager.associates(sent2)).first
    sent_assoc = create(sent1, sent2) if sent_assoc.nil?
    return if sent_assoc.nil?
    @meta_processor.process(sent_assoc)
  end

  def report
    report = "#{@created_count} SentenceAssociates created.\n"
    report << @errors
    report << @meta_processor.report
    report << "\n"
  end

  private

  def create(sent1, sent2)
    sent_assoc = SentenceAssociate.create(associate_a: sent1, associate_b: sent2)
    if sent_assoc.persisted?
      @sent_to_assocs[sent1] = [sent_assoc]
      @sent_to_assocs[sent2] = [sent_assoc]
      @created_count += 1
      return sent_assoc
    else
      @errors << "sent1: '#{sent1.entry}', sent2: '#{sent2.entry}'\n"
      return nil
    end
  end
end

require 'test_helper'

class SentencePairProcessorTest < ActiveSupport::TestCase
  setup do
    @english = Script.find(1)
    @italian = Script.find(3)
    @google = Source.find(2)
  end

  test 'process' do
    processor = SentencePairProcessor.new(@english, @italian, @google)
    processor.process([['A lovely bunch of coconuts.', 'Un bel mazzo di noci di cocco.']])
    processor.process([['A lovely bunch of coconuts.', 'Un bel mazzo di noci di cocco.']])
    processor = SentencePairProcessor.new(@english, @italian, @google)
    processor.process([[Sentence.first.entry, Sentence.second.entry]])
  end
end

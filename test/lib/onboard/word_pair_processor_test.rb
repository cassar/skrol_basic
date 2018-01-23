require 'test_helper'

class WordPairProcessorTest < ActiveSupport::TestCase
  setup do
    @english = Script.find(1)
    @italian = Script.find(3)
    @english_ipa = Script.find(2)
    @google = Source.find(2)
  end

  test 'process' do
    processor = WordPairProcessor.new(@english, @italian, @google)
    processor.process([%w[hello chao]])
    processor = WordPairProcessor.new(@english, @english_ipa, @google)
    processor.process([%w[hello həˈləʊ]])
  end
end

require 'test_helper'

class WordAssociateProcessorTest < ActiveSupport::TestCase
  setup do
    @english = Script.find(1)
    @italian = Script.find(3)
    @google = Source.find(2)
  end

  test 'process' do
    processor = WordAssociateProcessor.new(@english, @italian, @google)
    hello = @english.words.create(entry: 'hello')
    chao = @italian.words.create(entry: 'chao')
    assert_difference('WordAssociate.count', 1) do
      processor.process(hello, chao)
    end
  end
end

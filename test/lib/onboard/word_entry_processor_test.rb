require 'test_helper'

class WordEntryProcessorTest < ActiveSupport::TestCase
  setup do
    @english = Script.find(1)
    @google = Source.find(2)
  end

  test 'process' do
    processor = WordEntryProcessor.new(@english, @google)
    assert_difference('Word.count', 1) do
      processor.process('hippo')
    end
  end
end

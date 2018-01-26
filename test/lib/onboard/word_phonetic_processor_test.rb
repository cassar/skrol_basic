require 'test_helper'

class WordPhoneticProcessorTest < ActiveSupport::TestCase
  setup do
    @english = Script.find(1)
    @english_ipa = Script.find(2)
    @google = Source.find(2)
  end

  test 'process' do
    WordPhonetic.destroy_all
    processor = WordPhoneticProcessor.new(@english, @english_ipa, @google)
    assert_difference('WordPhonetic.count + MetaDatum.count', 2) do
      processor.process(Word.find(1), Word.find(2))
    end
  end
end

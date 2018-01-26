require 'test_helper'

class MetaDataProcessorTest < ActiveSupport::TestCase
  setup do
    @english = Script.find(1)
    @english_ipa = Script.find(2)
    @italian = Script.find(3)
    @google = Source.find(2)
  end

  test 'model_name = WordAssociate' do
    metas1 = @english.word_associate_meta_data(@google)
    metas2 = @italian.word_associate_meta_data(@google)
    processor = MetaDataProcessor.new(metas1 | metas2, @google, 'WordAssociate')
    assert_difference('MetaDatum.count', 1) do
      processor.process(WordAssociate.find(1))
    end
  end

  test 'model_name = WordPhonetic' do
    processor = MetaDataProcessor.new(@english.word_phonetic_meta_data, @google, 'WordPhonetic')
    assert_difference('MetaDatum.count', 1) do
      processor.process(WordPhonetic.find(1))
    end
  end
end

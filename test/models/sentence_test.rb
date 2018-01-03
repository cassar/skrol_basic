require 'test_helper'

class SentenceTest < ActiveSupport::TestCase
  setup do
    @std_sent = Sentence.find(1)
    @english_sent = Sentence.find(1)
    @spanish_sent = Sentence.find(2)
  end

  test 'sentence.all_associates' do
    assert_equal([@spanish_sent], @english_sent.all_associates)
    assert_equal([@english_sent], @spanish_sent.all_associates)
  end

  test 'sentence.corresponding' do
    english_std_script = Script.find(1)
    assert_equal(@english_sent, @spanish_sent.corresponding(english_std_script))
  end

  test 'destroy callback for SentenceAssociate' do
    @english_sent.destroy
    assert_nil(SentenceAssociate.take)
    assert(@spanish_sent.present?)
  end
end

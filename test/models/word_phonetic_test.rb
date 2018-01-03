require 'test_helper'

class WordPhoneticTest < ActiveSupport::TestCase
  test 'relations' do
    wf = WordPhonetic.take
    hello = Word.find(1)
    hello_phon = Word.find(28)

    assert_equal(hello, wf.standard, '.standard not working')
    assert_equal(hello_phon, wf.phonetic, '.phonetic not working')
  end
end

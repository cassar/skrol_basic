require 'test_helper'

class WordPhoneticManagerTest < ActiveSupport::TestCase
  setup do
    @standard_script = Script.find(1)
  end

  test 'check' do
    WordPhonetic.destroy_all
    checker = WordPhoneticManager.new(@standard_script)
    word = Word.find(1)
    checker.check(word)
    assert_equal(@standard_script.phonetic.words.find_by(entry: NONE), word.phonetic)
  end
end

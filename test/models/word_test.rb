require 'test_helper'

class WordTest < ActiveSupport::TestCase
  test 'Word.create should only save complete entries.' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin script (English alphabet)')
    word = script.words.create(entry: 'apple')
    script.words.create

    assert_equal(1, Word.count, 'Wrong number of words saved!')
    assert_not_nil(word.script, '.script method does not work.')
    assert_not_nil(word.language, '.language method does not work.')
  end
end

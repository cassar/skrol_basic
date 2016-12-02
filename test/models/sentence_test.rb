require 'test_helper'

class SentenceTest < ActiveSupport::TestCase
  test 'Sentence.create should only save complete entries.' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin script (English alphabet)')
    sentence = script.sentences.create(entry: 'Apple on my head.')
    script.sentences.create

    assert_equal(1, Sentence.count, 'Wrong number of sentences saved!')
    assert_not_nil(sentence.script, '.script method does not work.')
    assert_not_nil(sentence.language, '.language method does not work.')
  end
end

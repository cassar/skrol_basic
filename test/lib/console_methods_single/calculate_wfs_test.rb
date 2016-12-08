require 'test_helper'

class CalculateWFSTest < ActiveSupport::TestCase
  test 'calculate_wfs should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    script.sentences.create(entry: 'Would you like a apple a pear?')
    script.sentences.create(entry: 'I would like it.')
    word = script.words.create(entry: 'would')

    result = calculate_wfs(word)
    assert_equal(2.0 / 11, result, 'incorrect wfs score returned')
  end

  test 'count_sentence_words should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    sentence = script.sentences.create(entry: 'Would you like a apple a pear?')
    word = script.words.create(entry: 'would')

    result = count_sentence_words(word, sentence)
    assert_equal([1, 7], result, 'wrong array returned')
  end
end

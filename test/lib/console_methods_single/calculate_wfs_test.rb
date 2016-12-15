require 'test_helper'

class CalculateWFSTest < ActiveSupport::TestCase
  test 'calculate_wfs should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'would').first

    result = calculate_wfs(word)
    assert_equal(0.10344827586206896, result, 'incorrect wfs score returned')
  end

  test 'count_sentence_words should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    sentence =
      script.sentences.where(entry: 'Would you like a apple a pear?').first
    word = script.words.where(entry: 'would').first

    result = count_sentence_words(word, sentence)
    assert_equal([1, 7], result, 'wrong array returned')
  end
end

require 'test_helper'

class CalculateWLSTest < ActiveSupport::TestCase
  test 'calculate_wls should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    script.words.create(entry: 'neighbor')
    script.words.create(entry: 'top')

    calculate_wls(script)
    assert_equal(3, Score.count, 'wrong # of scores saved')
    score = word.scores.first
    assert_equal(0.25, score.score, 'incorrect wls score saved')
  end

  test 'compute_wls should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    score = compute_wls(word, 8)

    assert_equal(0.25, score, 'Incorrect wls score')
  end

  test 'max_word_length should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    script.words.create(entry: 'top')
    script.words.create(entry: 'kill')

    assert_equal(6, max_word_length(script), 'max method not working')
  end
end

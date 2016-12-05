require 'test_helper'

class CalculateWCFBSTest < ActiveSupport::TestCase
  test 'calculate_wcfts should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    word3 = script.words.create(entry: 'fun')
    populate_chars_cfs(script)

    lang2 = Language.create(name: 'Spanish')
    script2 = lang2.scripts.create(name: 'Latin')
    word2 = script2.words.create(entry: 'botella')
    populate_chars_cfs(script2)

    calculate_wcfts(word, script2)
    score = word.scores.where(score_name: 'WCFTS')
    assert_equal(1, score.count, 'Score did not save')
    assert_equal(0.166666666666667, score.first.score, 'incorrect WCFTS score')

    calculate_wcfts(word3, script2)
    score = word3.scores.where(score_name: 'WCFTS')
    assert_equal(0.0, score.first.score, 'WCFTS should be 0')
  end

  test 'return_cfils_score should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    populate_chars_cfs(script)

    increment = return_cfils_score('t', script)
    assert_equal(0.333333333333333, increment, 'incorrent amount incremented')

    increment = return_cfils_score('s', script)
    assert_equal(0.0, increment, 'should have returned 0')
  end
end

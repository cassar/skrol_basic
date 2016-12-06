require 'test_helper'

class CalculateWCFBSTest < ActiveSupport::TestCase
  test 'calculate_wfs should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    script.sentences.create(entry: 'Would you like a apple a pear?')
    word = script.words.create(entry: 'would')
    script.words.create(entry: 'you')
    script.words.create(entry: 'apple')
    script.words.create(entry: 'pear')

    calculate_wfs(script)
    assert_equal(4, Score.count, 'wrong number of scores saved')
    score = word.scores.first
    assert_equal(0.142857142857143, score.score, 'wrong score for would saved')

    script = lang.scripts.create(name: 'IPA')
    assert_raises(Invalid) { calculate_wfs(script) }
  end

  test 'return_total should work as advertised.' do
    catalogue = { 'bottle' => 1, 'in' => 1, 'sydney' => 1 }
    assert_equal(3, return_total(catalogue), 'wrong total returned')
  end

  test 'assign_wfs should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    word2 = script.words.create(entry: 'Sydney')

    catalogue = { 'bottle' => 1, 'in' => 1, 'sydney' => 1 }

    assign_wfs(script, catalogue, 3)

    assert_equal(2, Score.count, 'WFS scores did not save')
    score = word.scores.first
    assert_equal(0.333333333333333, score.score, 'wrong WFS score for bottle')
  end

  test 'return_word should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    word2 = script.words.create(entry: 'Sydney')

    assert_equal(word, return_word(script, 'bottle'), 'Did not find bottle')
    assert_equal(word2, return_word(script, 'sydney'), 'Did not find Sydney')
    assert_nil(return_word(script, 'soft'), 'error with none words')
  end
end

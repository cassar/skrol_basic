require 'test_helper'

class CalculateWCFBSTest < ActiveSupport::TestCase
  test 'calculate_wcfbs works as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    script.words.create(entry: 'crumble')
    populate_chars_cfs(script)

    calculate_wcfbs(word)

    wcfbs_score = word.scores.where(score_name: 'WCFBS').first
    assert_not_nil(wcfbs_score, 'WCFBS score did not save')
    assert_equal(0.141025641025641, wcfbs_score.score, 'Incorrect WCFBS score')
  end

  test 'return_cfs_score need works as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    populate_chars_cfs(script)

    increment = return_cfs_score('t', script)
    assert_equal(0.333333333333333, increment, 'incorrent amount incremented')
  end
end

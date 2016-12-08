require 'test_helper'

class CalculateWCFBSTest < ActiveSupport::TestCase
  test 'compile_wcfbs should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    script.words.create(entry: 'crumble')
    compile_chars_cfs(script)

    compile_wcfbs(word)

    wcfbs_score = word.scores.where(name: 'WCFBS').first
    assert_not_nil(wcfbs_score, 'WCFBS score did not save')
    assert_equal(0.141025641025641, wcfbs_score.entry, 'Incorrect WCFBS score')
  end

  test 'calculate_wcfbs works as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    script.words.create(entry: 'crumble')
    compile_chars_cfs(script)

    score = calculate_wcfbs(word)

    assert_equal(0.14102564102564114, score, 'Incorrect WCFBS score')
  end

  test 'return_cfs_score need works as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    compile_chars_cfs(script)

    increment = return_cfs_score('t', script)
    assert_equal(0.333333333333333, increment, 'incorrent amount incremented')
  end
end

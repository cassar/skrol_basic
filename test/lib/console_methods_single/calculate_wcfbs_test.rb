require 'test_helper'

class CalculateWCFBSTest < ActiveSupport::TestCase
  test 'compile_wcfbs should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'bottle').first
    compile_chars_cfs(script)

    lang2 = Language.where(name: 'Spanish').first
    script2 = lang2.scripts.where(name: 'Latin').first
    word2 = script2.words.create(entry: 'botella')
    compile_chars_cfs(script2)

    compile_wcfbs(word, script2)
    score = word.scores.where(name: 'WCFBS')
    assert_equal(1, score.count, 'Score did not save')
    assert_equal(0.101190476190476, score.first.entry, 'incorrect WCFBS score')
  end

  test 'calculate_wcfbs should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.create(entry: 'bottle')
    word3 = script.words.create(entry: 'fun')
    compile_chars_cfs(script)

    lang2 = Language.where(name: 'Spanish').first
    script2 = lang2.scripts.where(name: 'Latin').first
    word2 = script2.words.where(entry: 'botella').first
    compile_chars_cfs(script2)

    score = calculate_wcfbs(word, script2)
    assert_equal(0.10119047619047634, score, 'incorrect WCFBS score')
  end

  test 'return_cfils_score should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'bottle').first
    compile_chars_cfs(script)

    increment = return_cfils_score('t', script)
    assert_equal(0.0735294117647059, increment, 'incorrent amount incremented')
  end
end

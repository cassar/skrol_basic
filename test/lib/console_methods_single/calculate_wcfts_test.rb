require 'test_helper'

class CalculateWCFTSTest < ActiveSupport::TestCase
  test 'compile_wcfts should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    script.words.create(entry: 'crumble')
    compile_chars_cfs(script)

    compile_wcfts(word)

    wcfts_score = word.scores.where(name: 'WCFTS').first
    assert_not_nil(wcfts_score, 'WCFTS score did not save')
    assert_equal(0.141025641025641, wcfts_score.entry, 'Incorrect WCFTS score')
  end

  test 'calculate_wcfts works as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    script.words.create(entry: 'crumble')
    compile_chars_cfs(script)

    score = calculate_wcfts(word)

    assert_equal(0.14102564102564114, score, 'Incorrect WCFTS score')
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

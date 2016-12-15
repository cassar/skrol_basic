require 'test_helper'

class CalculateWCFTSTest < ActiveSupport::TestCase
  test 'compile_wcfts should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'bottle').first
    script.words.where(entry: 'crumble').first
    compile_chars_cfs(script)

    compile_wcfts(word)

    wcfts_score = word.scores.where(name: 'WCFTS').first
    assert_not_nil(wcfts_score, 'WCFTS score did not save')
    assert_equal(0.0857843137254902, wcfts_score.entry, 'Incorrect WCFTS score')
  end

  test 'calculate_wcfts works as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'bottle').first
    script.words.where(entry: 'crumble').first
    compile_chars_cfs(script)

    score = calculate_wcfts(word)

    assert_equal(0.08578431372549022, score, 'Incorrect WCFTS score')
  end

  test 'return_cfs_score need works as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'bottle').first
    compile_chars_cfs(script)

    increment = return_cfs_score('t', script)
    assert_equal(0.0735294117647059, increment, 'incorrent amount incremented')
  end
end

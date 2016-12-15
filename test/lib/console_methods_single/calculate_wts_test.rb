require 'test_helper'

class CalculateWTSTest < ActiveSupport::TestCase
  test 'compile_wts should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'bottle').first
    compile_chars_cfs(script)

    lang2 = Language.where(name: 'Italian').first
    script2 = lang2.scripts.where(name: 'Latin').first
    word2 = script2.words.where(entry: 'bottiglia').first
    compile_chars_cfs(script2)

    compile_wts(word2, script)
    score = word2.scores.where(name: 'WTS').first
    assert_not_nil(score, 'score did not save!')
    assert_equal(0.354365079365079, score.entry, 'incorrect score saved!')
  end

  test 'calculate_wts should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'bottle').first
    compile_chars_cfs(script)

    lang2 = Language.where(name: 'Italian').first
    script2 = lang2.scripts.where(name: 'Latin').first
    word2 = script2.words.where(entry: 'bottiglia').first
    compile_chars_cfs(script2)

    score = calculate_wts(word2, script)
    template = 0.3543650793650793
    assert_equal(template, score, 'Incorrect WTS score saved')
  end

  test 'return_word_scores should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'bottle').first
    compile_chars_cfs(script)

    lang2 = Language.where(name: 'Italian').first
    script2 = lang2.scripts.where(name: 'Latin').first
    word2 = script2.words.where(entry: 'bottiglia').first
    compile_chars_cfs(script2)

    template = [0.05555555555555555, 0.11111111111111081, 0.2857142857142857,
                0.0, 0.5777777777777777]
    result = return_word_scores(word2, script)
    assert_equal(template, result, 'Incorrect score array calculated')
  end
end

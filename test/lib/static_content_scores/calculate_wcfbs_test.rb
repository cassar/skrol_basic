require 'test_helper'

class CalculateWCFBSTest < ActiveSupport::TestCase
  test 'compile_wcfbs' do
    puts 'Test is empty!'
    # script = lang_by_name('English').base_script
    # word = script.word_by_entry('bottle')
    # compile_chars_cfs(script)
    #
    # script2 = lang_by_name('Spanish').base_script
    # word2 = script2.word_by_entry('botella')
    # compile_chars_cfs(script2)
    #
    # compile_wcfbs(word, script2)
    # score = word.scores.where(name: 'WCFBS')
    # assert_equal(1, score.count, 'Score did not save')
    # assert_equal(0.103448275862069, score.first.entry, 'incorrect WCFBS score')
  end

  test 'calculate_wcfbs' do
    puts 'Test is empty!'
    # script = lang_by_name('English').base_script
    # word = script.word_by_entry('bottle')
    # word3 = script.words.create(entry: 'fun')
    # compile_chars_cfs(script)
    #
    # script2 = lang_by_name('Spanish').base_script
    # word2 = script2.word_by_entry('botella')
    # compile_chars_cfs(script2)
    #
    # score = calculate_wcfbs(word, script2)
    # assert_equal(0.10344827586206885, score, 'incorrect WCFBS score')
  end

  test 'return_cfils_score' do
    puts 'Test is empty!'
    # script = lang_by_name('English').base_script
    # word = script.word_by_entry('bottle')
    # compile_chars_cfs(script)
    #
    # increment = return_cfils_score('t', script)
    # assert_equal(0.0735294117647059, increment, 'incorrent amount incremented')
  end
end

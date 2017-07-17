require 'test_helper'

class CalculateWTSTest < ActiveSupport::TestCase
  test 'compile_wts' do
    puts 'Test is empty!'
    # script = lang_by_name('English').base_script
    # lang_map = LangMap.first
    # base_script = lang_map.base_script
    # compile_chars_cfs(script)
    # compile_chars_cfs(script.phonetic)
    # compile_wfs_script(script)
    # compile_wls_script(script)
    #
    # script2 = lang_by_name('Italian').base_script
    # word2 = script2.word_by_entry('bottiglia')
    #
    # compile_chars_cfs(script2)
    # compile_chars_cfs(script2.phonetic)
    # compile_wfs_script(script2)
    # compile_wls_script(script2)
    #
    # compile_wts(word2, base_script, lang_map)
    # score = word2.scores.where(name: 'WTS').first
    # assert_not_nil(score, 'score did not save!')
    # assert(score.entry.is_a?(Float), 'incorrect score saved!')
    # score_count = word2.scores.where(name: 'WTS').count
    # assert_equal(1, score_count, 'Old score did not delete')
  end

  test 'calculate_wts' do
    puts 'Test is empty!'
    # script = lang_by_name('English').base_script
    #
    # compile_chars_cfs(script)
    # compile_chars_cfs(script.phonetic)
    # compile_wfs_script(script)
    # compile_wls_script(script)
    #
    # script2 = lang_by_name('Italian').base_script
    # word2 = script2.word_by_entry('bottiglia')
    #
    # compile_chars_cfs(script2)
    # compile_chars_cfs(script2.phonetic)
    # compile_wfs_script(script2)
    # compile_wls_script(script2)
    #
    # score = calculate_wts(word2, script)
    # assert(score.is_a?(Float), 'Incorrect WTS score saved')
  end

  test 'return_word_scores' do
    puts 'Test is empty!'
    # script = lang_by_name('English').base_script
    # compile_chars_cfs(script)
    # compile_chars_cfs(script.phonetic)
    # compile_wfs_script(script)
    # compile_wls_script(script)
    #
    # script2 = lang_by_name('Italian').base_script
    # word2 = script2.word_by_entry('bottiglia')
    # compile_chars_cfs(script2)
    # compile_chars_cfs(script2.phonetic)
    # compile_wfs_script(script2)
    # compile_wls_script(script2)
    #
    # result = return_word_scores(word2, script)
    # assert_equal(5, result.count, 'Incorrect score array calculated')
  end

  test 'retrieve_word_score_entry' do
    puts 'Test is empty!'
  end
end

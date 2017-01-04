require 'test_helper'

class CalculateWTSTest < ActiveSupport::TestCase
  test 'compile_wts' do
    script = lang_by_name('English').base_script
    compile_chars_cfs(script)
    compile_chars_cfs(script.phonetic)

    script2 = lang_by_name('Italian').base_script
    word2 = script2.word_by_entry('bottiglia')
    compile_chars_cfs(script2)
    compile_chars_cfs(script2.phonetic)

    compile_wts(word2, script)
    score = word2.scores.where(name: 'WTS').first
    assert_not_nil(score, 'score did not save!')
    assert_equal(0.160480048500882, score.entry, 'incorrect score saved!')
    assert_equal(1, word2.scores.count, 'Old score did not delete')
  end

  test 'calculate_wts' do
    script = lang_by_name('English').base_script
    compile_chars_cfs(script)
    compile_chars_cfs(script.phonetic)

    script2 = lang_by_name('Italian').base_script
    word2 = script2.word_by_entry('bottiglia')
    compile_chars_cfs(script2)
    compile_chars_cfs(script2.phonetic)

    score = calculate_wts(word2, script)
    template = 0.16048004850088182
    assert_equal(template, score, 'Incorrect WTS score saved')
  end

  test 'return_word_scores' do
    script = lang_by_name('English').base_script
    compile_chars_cfs(script)
    compile_chars_cfs(script.phonetic)

    script2 = lang_by_name('Italian').base_script
    word2 = script2.word_by_entry('bottiglia')
    compile_chars_cfs(script2)
    compile_chars_cfs(script2.phonetic)

    template = [0.03125, 0.16049382716049362, 0.2857142857142857, 0.0, 0.1875]
    result = return_word_scores(word2, script)
    assert_equal(template, result, 'Incorrect score array calculated')
  end
end

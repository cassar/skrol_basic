require 'test_helper'

class CompileWLSScriptTest < ActiveSupport::TestCase
  test 'compile_wls_script should work as advertised' do
    script = lang_by_name('English').base_script
    word = script.word_by_entry('apple')

    compile_wls_script(script)
    assert_equal(script.words.count, Score.count, 'wrong # of scores saved')
    score = word.scores.where(name: 'WLS').first
    assert_equal(0.285714285714286, score.entry, 'incorrect wls score saved')
  end

  test 'compute_wls should work as advertised' do
    script = lang_by_name('English').base_script
    word = script.word_by_entry('bottle')
    score = compute_wls(word, 8)

    assert_equal(0.25, score, 'Incorrect wls score')
  end
end

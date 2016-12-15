require 'test_helper'

class CompileWLSScriptTest < ActiveSupport::TestCase
  test 'compile_wls_script should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'apple').first

    compile_wls_script(script)
    assert_equal(script.words.count, Score.count, 'wrong # of scores saved')
    score = word.scores.where(name: 'WLS').first
    assert_equal(0.285714285714286, score.entry, 'incorrect wls score saved')
  end

  test 'compute_wls should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'bottle').first
    score = compute_wls(word, 8)

    assert_equal(0.25, score, 'Incorrect wls score')
  end
end

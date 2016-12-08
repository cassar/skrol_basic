require 'test_helper'

class CompileWLSScriptTest < ActiveSupport::TestCase
  test 'compile_wls_script should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    script.words.create(entry: 'neighbor')
    script.words.create(entry: 'top')

    compile_wls_script(script)
    assert_equal(3, Score.count, 'wrong # of scores saved')
    score = word.scores.first
    assert_equal(0.25, score.entry, 'incorrect wls score saved')
  end

  test 'compute_wls should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    score = compute_wls(word, 8)

    assert_equal(0.25, score, 'Incorrect wls score')
  end
end

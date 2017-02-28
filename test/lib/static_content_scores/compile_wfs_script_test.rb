require 'test_helper'

class CompileWFSScriptTest < ActiveSupport::TestCase
  test 'compile_wfs_script' do
    lang = lang_by_name('English')
    script = lang.scripts.find_by name: 'Latin'
    word = script.words.find_by entry: 'would'
    script.sentences.destroy_all
    sentence =
      script.sentences.create(entry: 'Would you like a apple a pear?')

    compile_wfs_script(script)
    expect = script.words.count
    result = Score.where(name: 'WFS').count
    assert_equal(expect, result, 'wrong number of scores saved')
    score = word.scores.first
    assert_equal(0.142857142857143, score.entry, 'wrong score for would saved')

    script = lang.scripts.create(name: 'IPA')
    assert_raises(Invalid) { compile_wfs_script(script) }
  end

  test 'return_word_total' do
    catalogue = { 'bottle' => 1, 'in' => 1, 'sydney' => 1 }
    assert_equal(3, return_word_total(catalogue), 'wrong total returned')
  end

  test 'assign_wfs' do
    script = lang_by_name('English').base_script
    word = script.words.where(entry: 'bottle').first
    word2 = script.words.where(entry: 'Sydney').first

    catalogue = { 'bottle' => 1, 'in' => 1, 'sydney' => 1 }

    assign_wfs(script, catalogue, 3)
    template = script.words.count
    result = Score.where(name: 'WFS').count
    assert_equal(template, result, 'WFS scores did not save')
    score = word.scores.first
    assert_equal(0.333333333333333, score.entry, 'wrong WFS score for bottle')
  end
end

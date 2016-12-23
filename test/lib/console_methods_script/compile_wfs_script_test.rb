require 'test_helper'

class CompileWFSScriptTest < ActiveSupport::TestCase
  test 'compile_wfs_script' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'would').first
    script.sentences.each(&:destroy)
    sentence =
      script.sentences.create(entry: 'Would you like a apple a pear?')

    compile_wfs_script(script)
    expect = derive_words_catalogue(script).count
    assert_equal(expect, Score.count, 'wrong number of scores saved')
    score = word.scores.first
    assert_equal(0.142857142857143, score.entry, 'wrong score for would saved')

    script = lang.scripts.create(name: 'IPA')
    assert_raises(Invalid) { compile_wfs_script(script) }
  end

  test 'derive_words_catalogue' do
    script = lang_by_name('English').base_script
    script.sentences.each(&:destroy)
    sentence =
      script.sentences.create(entry: 'Would you like a apple a pear?')

    template = { 'would' => 1, 'you' => 1, 'like' => 1,
                 'a' => 2, 'apple' => 1, 'pear' => 1 }

    assert_equal(template, derive_words_catalogue(script), 'objects not equal')
  end

  test 'add_words_to_catalogue' do
    script = lang_by_name('English').base_script
    sentence =
      script.sentences.where(entry: 'Would you like a apple a pear?').first

    catalogue = { 'apple' => 2, 'pear' => 1 }
    add_words_to_catalogue(sentence, catalogue)
    assert_equal(1, catalogue['would'], 'would should have 1 count')
    assert_equal(3, catalogue['apple'], 'apple should have 2 count')
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
    assert_equal(2, Score.where(name: 'WFS').count, 'WFS scores did not save')
    score = word.scores.first
    assert_equal(0.333333333333333, score.entry, 'wrong WFS score for bottle')
  end
end

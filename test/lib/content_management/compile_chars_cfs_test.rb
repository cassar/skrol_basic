require 'test_helper'

class PopulateCharsCFSTest < ActiveSupport::TestCase
  test 'compile_chars_cfs' do
    script = lang_by_name('English').base_script

    compile_chars_cfs(script)
    char_count = script.characters.count
    cfs_count = Score.where(name: 'CFS').count
    assert_equal(char_count, cfs_count, 'Wrong number of scores saved!')

    char = Character.where(entry: 'h').first
    score_record = char.scores.first
    assert_not_nil(score_record, 'No score record found.')
    template = 0.0441176470588235
    assert_equal(template, score_record.entry, 'h should be different')

    char = Character.where(entry: 'l').first
    score_record = char.scores.first
    assert_not_nil(score_record, 'No score record found.')
    template = 0.102941176470588
    assert_equal(template, score_record.entry, 'l should be different')
  end

  test 'create_chars_return_total' do
    script = lang_by_name('English').base_script
    char = script.characters.where(entry: 'h').first
    catalogue = { h: 1, e: 1, l: 2, o: 1 }

    total = create_chars_return_total(catalogue, script)
    assert_equal(4, Character.count, 'Incorrct # of chars created.')
    assert_equal(5, total, 'Incorrect total returned.')
  end

  test 'create_cfs_scores' do
    script = lang_by_name('English').base_script
    char = script.characters.where(entry: 'h').first
    catalogue = { h: 1, e: 1, l: 2, o: 1 }
    create_cfs_scores(catalogue, script, 5)
    score = char.scores.first
    score_count = Score.where(name: 'CFS').count
    assert_equal(4, score_count, 'Incorrect number of scores saved.')
    assert_equal(0.2, score.entry, 'h should have score of .2')
    assert_equal('CFS', score.name, 'score name should be CFS')

    char.destroy
    assert_raises(Invalid) { create_cfs_scores(catalogue, script, 5) }
  end

  test 'derive_chars_catalogue' do
    script = lang_by_name('English').base_script
    script.words.each(&:destroy)
    script.words.create(entry: 'apple')

    template = { 'a' => 1, 'p' => 2, 'l' => 1, 'e' => 1 }
    assert_equal(template, derive_chars_catalogue(script), 'objects not equal')
  end

  test 'add_chars_to_catalogue' do
    script = lang_by_name('English').base_script
    word = script.word_by_entry('apple')

    catalogue = { a: 0, p: 0, l: 0, e: 0 }
    add_chars_to_catalogue(word, catalogue)
    assert_equal(1, catalogue['a'], 'a should have 1 count')
    assert_equal(2, catalogue['p'], 'p should have 2 count')
  end
end

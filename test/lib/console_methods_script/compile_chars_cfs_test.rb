require 'test_helper'

class PopulateCharsCFSTest < ActiveSupport::TestCase
  test 'compile_chars_cfs should word as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first

    compile_chars_cfs(script)
    char_count = script.characters.count
    assert_equal(char_count, Score.count, 'Wrong number of scores saved!')

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

  test 'create_chars_return_total should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    char = script.characters.where(entry: 'h').first
    catalogue = { h: 1, e: 1, l: 2, o: 1 }

    total = create_chars_return_total(catalogue, script)
    assert_equal(4, Character.count, 'Incorrct # of chars created.')
    assert_equal(5, total, 'Incorrect total returned.')
  end

  test 'create_cfs_scores should word as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    char = script.characters.where(entry: 'h').first
    catalogue = { h: 1, e: 1, l: 2, o: 1 }
    create_cfs_scores(catalogue, script, 5)
    score = char.scores.first
    assert_equal(4, Score.count, 'Incorrect number of scores saved.')
    assert_equal(0.2, score.entry, 'h should have score of .2')
    assert_equal('CFS', score.name, 'score name should be CFS')

    char.destroy
    assert_raises(Invalid) { create_cfs_scores(catalogue, script, 5) }
  end
end

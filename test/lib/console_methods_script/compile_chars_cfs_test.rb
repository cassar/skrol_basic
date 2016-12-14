require 'test_helper'

class PopulateCharsCFSTest < ActiveSupport::TestCase
  test 'compile_chars_cfs should word as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.create(name: 'Latin')
    script.words.create(entry: 'hello')
    script.words.create(entry: 'cow')

    compile_chars_cfs(script)
    assert_equal(6, Score.count, 'Wrong number of scores saved!')

    char = Character.where(entry: 'h').first
    score_record = char.scores.first
    assert_not_nil(score_record, 'No score record found.')
    assert_equal(0.125, score_record.entry, 'h should have been 0.125')

    char = Character.where(entry: 'l').first
    score_record = char.scores.first
    assert_not_nil(score_record, 'No score record found.')
    assert_equal(0.25, score_record.entry, 'l should have been 0.25')
  end

  test 'create_chars_return_total should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.create(name: 'Latin')
    char = script.characters.create(entry: 'h')
    script.characters.create(entry: 'e')
    catalogue = { h: 1, e: 1, l: 2, o: 1 }

    total = create_chars_return_total(catalogue, script)
    assert_equal(4, Character.count, 'Incorrct # of chars created.')
    assert_equal(5, total, 'Incorrect total returned.')
  end

  test 'create_cfs_scores should word as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.create(name: 'Latin')
    char = script.characters.create(entry: 'h')
    script.characters.create(entry: 'e')
    script.characters.create(entry: 'l')
    script.characters.create(entry: 'o')
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

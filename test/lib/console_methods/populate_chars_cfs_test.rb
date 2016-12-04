require 'test_helper'

class PopulateCharsCFSTest < ActiveSupport::TestCase
  # Error handing needs to be brought up to scratch.
  # populate_chars_cfs should throw an error if it exits on the first line.
  test 'Score and Character counts should be correct' do
    Word.create(base: 'hello', phonetic: 'hɛˈloʊ̯', language: 'en', en_equiv: 1)
    Word.create(base: 'cow', phonetic: 'kaʊ̯', language: 'en', en_equiv: 2)
    populate_chars_cfs('en', 'base')

    count = Score.where(score_name: 'CFS').count
    assert_equal(6, count, 'score count should be 6.')

    count = Character.where(language: 'en', script: 'base').count
    assert_equal(6, count, 'character count should be 6.')
  end

  # This doesn't work sometimes and I don't like it.
  test 'populate_chars_cfs should save the correct CFS score' do
    Word.create(base: 'hello', phonetic: 'hɛˈloʊ̯', language: 'en', en_equiv: 1)
    Word.create(base: 'cow', phonetic: 'kaʊ̯', language: 'en', en_equiv: 2)
    populate_chars_cfs('en', 'base')

    char_id = Character.where(entry: 'h').first['id']
    score_record = Score.where(id: char_id, score_name: 'CFS')
    assert_not_nil(score_record, 'No score record found.')
    assert_equal(0.125, score_record.first['score'], 'h should have been 0.125')

    char_id = Character.where(entry: 'l').first['id']
    score_record = Score.where(id: char_id, score_name: 'CFS')
    assert_not_nil(score_record, 'No score record found.')
    assert_equal(0.25, score_record.first['score'], 'l should have been 0.25')
  end

  test 'create_characters_return_total as addvertised' do
    catalogue = { h: 1, e: 1, l: 2, o: 1 }
    total = create_chars_return_total(catalogue, 'en', 'base')
    assert_equal(4, Character.count, 'Incorrct # of chars created.')
    assert_equal(5, total, 'Incorrect total returned.')
  end

  test 'create_cfs_scores should create some scores' do
    char = Character.create(entry: 'h', language: 'en', script: 'base')
    catalogue = { h: 1, e: 1, l: 2, o: 1 }
    create_cfs_scores(catalogue, 'en', 'base', 5)
    score = char.scores.first
    assert_equal(0.2, score['score'], 'h should have score of .2')
    assert_equal('CFS', score['score_name'], 'score name should be CFS')
  end

  test 'add_chars_to_catalogue should do what it says' do
    word = Word.create(base: 'hello', phonetic: 'hɛˈloʊ̯', language: 'en',
                       en_equiv: 1)
    catalogue = { h: 0, e: 0, l: 0, o: 0 }
    add_chars_to_catalogue(word, 'base', catalogue)
    assert_equal(1, catalogue['h'], 'h should have 1 count')
    assert_equal(2, catalogue['l'], 'l should have 2 count')
  end
end

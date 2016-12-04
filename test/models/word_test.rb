require 'test_helper'

class WordTest < ActiveSupport::TestCase
  test 'Word.create and destroy should satisfy integrity constraints' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin script (English alphabet)')
    word = script.words.create(entry: 'apple')
    script.words.create(entry: 'apple')
    script.words.create

    lang = Language.create(name: 'Spanish')
    script = lang.scripts.create(name: 'Latin script (Spanish alphabet)')
    word = script.words.create(entry: 'apple')
    score = word.scores.create(map_to_id: 2, map_to_type: 'words',
                               score_name: 'WSS', score: 0.23)

    assert_not_nil(score, 'Score did not save.')
    assert_equal(1, Score.count, 'No scores saved.')

    assert_equal(2, Word.count, 'Wrong number of words saved!')
    assert_not_nil(word.script, '.script method does not work.')
    assert_not_nil(word.language, '.language method does not work.')

    word.destroy
    assert_equal(0, Score.count, 'Score did not destroy.')
  end

  test '.phonetic and .create_phonetic methods should work.' do
    lang = Language.create(name: 'English')

    b_script = lang.scripts.create(name: 'Latin script (English alphabet)')
    p_script = b_script.create_phonetic('IPA')

    b_word = b_script.words.create(entry: 'apple')
    p_word = b_word.create_phonetic('ˈæ.pl̩')

    assert_equal(2, Word.count, 'wrong number of words saved.')
    assert_equal(b_word['group_id'], p_word['group_id'], 'group_id mismatch!')
    assert_equal(p_word, b_word.phonetic, ".phonetic doesn't work")
  end
end

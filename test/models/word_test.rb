require 'test_helper'

class WordTest < ActiveSupport::TestCase
  test 'Word.create and destroy should satisfy integrity constraints' do
    script = lang_by_name('English').base_script

    script2 = lang_by_name('Spanish').base_script

    assert_difference('Word.count', 2, 'Wrong number of words saved!') do
      script.words.create(entry: 'unique')
      script.words.create(entry: 'unique')
      script.words.create

      script2.words.create(entry: 'unique')
    end

    word = script.word_by_entry('apple')
    score = word.scores.create(map_to_id: 2, map_to_type: 'words',
                               name: 'WSS', entry: 0.23)

    assert_not_nil(score, 'Score did not save.')
    assert_equal(1, Score.count, 'No scores saved.')

    assert_not_nil(word.script, '.script method does not work.')
    assert_not_nil(word.language, '.language method does not work.')

    word.destroy
    assert_equal(0, Score.count, 'Score did not destroy.')
  end

  test '.phonetic and .create_phonetic methods should work.' do
    lang = Language.create(name: 'Chinese')

    b_script = lang.scripts.create(name: 'Hanzi')
    p_script = b_script.create_phonetic('IPA')

    b_word = b_script.words.create(entry: 'apple')
    p_word = ''
    assert_difference('Word.count', 1, 'wrong number of words saved') do
      p_word = b_word.create_phonetic('ˈæ.pl̩')
    end

    assert_equal(b_word.group_id, p_word.group_id, 'group_id mismatch!')
    assert_equal(p_word, b_word.phonetic, ".phonetic doesn't work")
  end
end

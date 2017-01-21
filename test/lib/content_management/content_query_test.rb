require 'test_helper'

class ContentQueryTest < ActiveSupport::TestCase
  test 'lang_by_name' do
    assert_not_nil(lang_by_name('English'), 'Failed to retrieve English.')
    assert_raises(Invalid, 'Did not raises Invalid') do
      lang_by_name('Jibberish')
    end
  end

  test 'user_by_name' do
    assert_not_nil(user_by_name('Luke'), 'Failed to retrieve Luke')
    assert_raises(Invalid, 'Did not raises Invalid') do
      lang_by_name('No_name')
    end
  end

  test 'lang_by_id' do
    assert_equal(lang_by_name('English'), lang_by_id(1), 'method not working')
    assert_raises(Invalid, 'Did not raise Invalid') { lang_by_id(50) }
  end

  test 'word_by_id' do
    word = lang_by_name('English').base_script.word_by_entry('hello')
    assert_equal(word, word_by_id(1), 'method not working properly')
    assert_raises(Invalid, 'Did not raise Invalid') { word_by_id(-1) }
  end

  test 'word_by_rank' do
  end

  test 'sentence_by_id' do
    sent = Sentence.first
    assert_equal(sent, sentence_by_id(1), 'method did not work')
    assert_raises(Invalid, 'Did not raise Invalid') { sentence_by_id(-1) }
  end

  test 'retrieve_char' do
    entry = 'h'
    script = lang_by_name('English').base_script
    template = Character.where(entry: 'h').first
    result = retrieve_char(entry, script)
    assert_equal(template, result, 'incorrect score record returned')
    assert_raises(Invalid, 'Invalid not raised') { retrieve_char('a', script) }
  end

  test 'return_word' do
    script = lang_by_name('English').base_script
    word = script.words.where(entry: 'bottle').first
    word2 = script.words.where(entry: 'sydney').first

    assert_equal(word, return_word('bottle', script), 'Did not find bottle')
    assert_equal(word2, return_word('sydney', script), 'Did not find Sydney')
    assert_nil(return_word('soft', script), 'error with none words')
  end
end

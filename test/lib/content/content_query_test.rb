require 'test_helper'

class ContentQueryTest < ActiveSupport::TestCase
  test 'lang_by_name' do
    assert_not_nil(lang_by_name('English'), 'Failed to retrieve English.')
    assert_raises(ActiveRecord::RecordNotFound, 'Did not raises Invalid') do
      lang_by_name('Jibberish')
    end
  end

  test 'user_by_name' do
    assert_not_nil(user_by_name('Luke'), 'Failed to retrieve Luke')
    assert_raises(ActiveRecord::RecordNotFound, 'Did not raises Invalid') do
      lang_by_name('No_name')
    end
  end

  test 'word_by_rank' do
  end

  test 'retrieve_char' do
    entry = 'h'
    script = lang_by_name('English').standard_script
    template = Character.where(entry: 'h').first
    result = retrieve_char(entry, script)
    assert_equal(template, result, 'incorrect score record returned')
    assert_raises(ActiveRecord::RecordNotFound, 'Invalid not raised') do
      retrieve_char('a', script)
    end
  end

  test 'return_word' do
    script = lang_by_name('English').standard_script
    word = script.words.where(entry: 'bottle').first
    word2 = script.words.where(entry: 'sydney').first

    assert_equal(word, return_word('bottle', script), 'Did not find bottle')
    assert_equal(word2, return_word('sydney', script), 'Did not find Sydney')
    assert_nil(return_word('soft', script), 'error with none words')
  end

  test 'retrieve_word_ranks' do
  end

  test 'retrieve_sts' do
  end
end

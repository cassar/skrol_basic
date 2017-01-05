require 'test_helper'

class QueryMethodsTest < ActiveSupport::TestCase
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

  test 'sentence_by_id' do
    sent = Sentence.first
    assert_equal(sent, sentence_by_id(1), 'method did not work')
    assert_raises(Invalid, 'Did not raise Invalid') { sentence_by_id(-1) }
  end

  test 'user_by_id' do
    user = User.first
    assert_equal(user, user_by_id(1), 'incorrect user record returned')
    assert_raises(Invalid, 'invalid not raised') { user_by_id(-1) }
  end

  test 'user_score_by_metric' do
    metric = UserMetric.second
    score = UserScore.first
    result = user_score_by_metric(metric)
    assert_equal(score, result, 'incorrect score returned')
    metric = UserMetric.first
    assert_raises(Invalid, 'Invalid Failed to raise') do
      user_score_by_metric(metric)
    end
  end

  test 'retrieve_wts' do
    word_id = 26
    base_script = lang_by_name('English').base_script
    template = Score.first
    result = retrieve_wts(word_id, base_script)
    assert_equal(template, result, 'incorrect score retrieved')
    assert_raises(Invalid, 'Invalid not raised') do
      word_id = 1
      retrieve_wts(word_id, base_script)
    end
  end
end

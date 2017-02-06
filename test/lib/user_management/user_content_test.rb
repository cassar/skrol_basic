require 'test_helper'

class UserContentTest < ActiveSupport::TestCase
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

  test 'word_used?' do
    word = Word.find(14)
    user_map = UserMap.first
    assert(word_used?(word, user_map), 'incorrect bool returned')
    word = Word.find(15)
    assert_not(word_used?(word, user_map), 'incorrect bool returned')
  end

  test 'sentence_used?' do
    sentence = Sentence.find(1)
    user_map = UserMap.first
    assert(sentence_used?(sentence, user_map), 'incorrect bool returned')
    sentence = Sentence.find(2)
    assert_not(sentence_used?(sentence, user_map), 'incorrect bool returned')
  end
end

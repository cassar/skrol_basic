require 'test_helper'

class UserContentTest < ActiveSupport::TestCase
  test 'user_score_by_metric' do
    metric = UserMetric.second
    score = UserScore.first
    result = user_score_by_metric(metric)
    assert_equal(score, result, 'incorrect score returned')
    metric = UserMetric.first
    assert_raises(ActiveRecord::RecordNotFound, 'Invalid Failed to raise') do
      user_score_by_metric(metric)
    end
  end

  test 'word_used?' do
    word = Word.find(14)
    enrolment = Enrolment.first
    assert(word_used?(word, enrolment), 'incorrect bool returned')
    word = Word.find(15)
    assert_not(word_used?(word, enrolment), 'incorrect bool returned')
  end

  test 'sentence_used?' do
    sentence = Sentence.find(1)
    enrolment = Enrolment.first
    assert(sentence_used?(sentence, enrolment), 'incorrect bool returned')
    sentence = Sentence.find(2)
    assert_not(sentence_used?(sentence, enrolment), 'incorrect bool returned')
  end
end

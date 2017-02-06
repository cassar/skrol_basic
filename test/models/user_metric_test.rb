require 'test_helper'

class UserMetricTest < ActiveSupport::TestCase
  test 'user_metrics validations' do
    user_map = UserMap.first
    call = 'user_map.user_metrics.count'
    assert_difference(call, 1, 'wrong # of user_metrics saved') do
      user_map.user_metrics.create
      user_map.user_metrics.create(target_word_id: 1)
      user_map.user_metrics.create(target_word_id: 1, target_sentence_id: 1,
                                   speed: 20, pause: true, hover: false, hide: true)
      user_map.user_metrics.create(target_word_id: 1, target_sentence_id: 1,
                                   speed: 20, pause: true, hover: false, hide: true)
    end
  end

  test 'user_metric associatons' do
    user_map = UserMap.first
    metric = user_map.user_metrics.create(target_word_id: 1, target_sentence_id: 1,
                                          speed: 20, pause: true, hover: false,
                                          hide: true)
    assert_equal(user_map, metric.user_map, '.user does not work')
  end

  test 'UserMetic.apply_user_score' do
    metric = UserMetric.second
    metric.update(speed: 30, pause: false, hover: false, hide: false)
    metric.apply_user_score
    score = UserScore.first
    assert_equal(1.0, score.entry, 'incorrect score saved')
  end
end

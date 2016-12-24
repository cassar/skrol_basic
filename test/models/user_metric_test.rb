require 'test_helper'

class UserMetricTest < ActiveSupport::TestCase
  test 'user_metrics validations' do
    user = user_by_name('Luke')
    call = 'user.user_metrics.count'
    assert_difference(call, 1, 'wrong # of user_metrics saved') do
      user.user_metrics.create
      user.user_metrics.create(target_word_id: 1)
      user.user_metrics.create(target_word_id: 1, target_sentence_id: 1,
                               speed: 20, pause: true, hover: false, hide: true)
      user.user_metrics.create(target_word_id: 1, target_sentence_id: 1,
                               speed: 20, pause: true, hover: false, hide: true)
    end
  end

  test 'user_metric associatons' do
    user = user_by_name('Luke')
    metric = user.user_metrics.create(target_word_id: 1, target_sentence_id: 1,
                                      speed: 20, pause: true, hover: false,
                                      hide: true)
    assert_equal(user, metric.user, '.user does not work')
  end

  test 'UserMetic.apply_user_score' do
    metric = UserMetric.second
    metric.update(speed: 30, pause: false, hover: false, hide: false)
    score = UserScore.first
    assert_equal(0.8, score.entry, 'incorrect score saved')
  end
end

require 'test_helper'

class UpdateUserMetricTest < ActiveSupport::TestCase
  test 'update_user_metric' do
    obj = { 'group_id' => '2', 'word_id' => '14', 'enrolment_id' => '1',
            'speed' => '3', 'pause' => 'false', 'hover' => 'true',
            'hide' => 'false' }
    update_user_metric(obj)
    metric = UserMetric.second
    assert_not(metric.hide, 'hide metric did not change')
    assert_equal(3, metric.speed, 'incorrect score saved')
  end

  test 'return_search_fields' do
  end

  test 'return_target_sentence_id' do
  end

  test 'return_user_metric' do
  end

  test 'create_metric_and_score' do
  end

  test 'return_metric_results' do
  end

  test 'update_metric' do
  end

  test 'return_user_word_score' do
    metric = UserMetric.second
    score = UserScore.first
    result = return_user_word_score(metric, score)
    assert(result.is_a?(Float), 'result is not float')
  end

  test 'fix_new_entry' do
    result = fix_new_entry(0.5)
    assert_equal(0.5, result, 'incorrect value returned')
    result = fix_new_entry(-1)
    assert_equal(0.0, result, 'incorrect value returned')
    result = fix_new_entry(2.0)
    assert_equal(1.0, result, 'incorrect value returned')
  end

  test 'return_speed_adjustment' do
    result = return_speed_adjustment(2)
    assert(result.is_a?(Float), 'incorrect score returned')
  end
end

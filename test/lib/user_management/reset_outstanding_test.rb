require 'test_helper'

class ResetOutstandingTest < ActiveSupport::TestCase
  test 'reset_outstanding' do
    user_map = UserMap.first
    assert_difference('UserMetric.count', -1, 'metric was not removed') do
      reset_outstanding(user_map)
    end
    result = UserScore.where(status: TESTING).count
    assert_equal(0, result, 'user score not reset')
  end
end

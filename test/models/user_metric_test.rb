require 'test_helper'

class UserMetricTest < ActiveSupport::TestCase
  test 'UserMetic.apply_user_score' do
    metric = UserMetric.second
    metric.update(speed: 30, pause: false, hover: false, hide: false)
    metric.apply_user_score
  end
end

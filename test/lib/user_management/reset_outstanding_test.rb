require 'test_helper'

class ResetOutstandingTest < ActiveSupport::TestCase
  test 'reset_outstanding' do
    user = User.first
    assert_difference('UserMetric.count', -1, 'metric was not removed') do
      user.reset_outstanding
    end
    result = UserScore.where(status: TESTING).count
    assert_equal(0, result, 'user score not reset')
    sentence_rank = UserScore.where(id: 3).first.sentence_rank
    assert_equal(1, sentence_rank, 'sentence_rank did not decrement')
  end
end

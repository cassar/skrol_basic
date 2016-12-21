require 'test_helper'

class UserScoreTest < ActiveSupport::TestCase
  test 'user_score validations work' do
    user = user_by_name('Luke')
    call = 'user.user_scores.count'
    assert_difference(call, 1, 'wrong number of scores saved') do
      user.user_scores.create
      user.user_scores.create(target_word_id: 1, status: 'tested')
      user.user_scores.create(target_word_id: 1, score: 0.5, status: 'tested')
      user.user_scores.create(target_word_id: 1, score: 0.5, status: 'tested')
    end
    score = user.user_scores.create(target_word_id: 1, score: 0.5,
                                    status: 'tested')
    assert_equal(user, score.user, '.user accosiation does not work')
  end
end

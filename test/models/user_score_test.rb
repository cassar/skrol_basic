require 'test_helper'

class UserScoreTest < ActiveSupport::TestCase
  test 'user_score validations' do
    user_map = UserMap.first
    call = 'user_map.user_scores.count'
    assert_difference(call, 1, 'wrong number of scores saved') do
      user_map.user_scores.create
      user_map.user_scores.create(target_word_id: 1, status: 'tested')
      user_map.user_scores.create(target_word_id: 1, entry: 0.5, status: 'tested')
      user_map.user_scores.create(target_word_id: 1, entry: 0.5, status: 'tested')
    end
    score = user_map.user_scores.create(target_word_id: 1, entry: 0.5,
                                        status: 'tested')
    assert_equal(user_map, score.user_map, '.user_map association does not work')
  end

  test 'User.target_script' do
    user_score = UserScore.first

    template = lang_by_name('Spanish').base_script
    result = user_score.target_script
    assert_equal(template, result, 'target_script did not work')
  end
end

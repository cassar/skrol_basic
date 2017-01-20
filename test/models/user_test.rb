require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'User validations' do
    call = 'User.count'
    assert_difference(call, 1, 'should have saved') do
      User.create(name: 'Kyle')
      User.create(name: 'Kyle')
    end
  end

  test 'User associations' do
    user = user_by_name('Luke')
    call = 'user.user_scores.count'
    assert_difference(call, 1, 'score did not save') do
      user.user_scores.create(target_word_id: 15, entry: 0.09, status: 'tested')
    end
    call = 'user.user_metrics.count'
    assert_difference(call, 1, 'score did not save') do
      user.user_metrics.create(target_word_id: 14, target_sentence_id: 9,
                               speed: 40, pause: false, hover: true,
                               hide: false)
    end
  end

  test 'User.create_touch_score' do
    user = user_by_name('Luke')
    target_word = word_by_id(14)
    call = 'UserScore.count'
    assert_difference(call, 0, 'score did not update') do
      user.create_touch_score(target_word)
    end
    target_word = word_by_id(13)
    assert_difference(call, 1, 'score did not update') do
      user.create_touch_score(target_word)
    end
  end

  test 'User.create_metric_stub' do
    user = user_by_name('Luke')
    target_sentence = sentence_by_id(3)
    target_word = word_by_id(1)
    call = 'UserMetric.count'
    assert_difference(call, 1, 'metric failed to save') do
      user.create_metric_stub(target_word, target_sentence)
    end
  end

  test 'User.raise_to_threshold' do
  end
end

require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'User validations' do
    call = 'User.count'
    assert_difference(call, 0, 'should not have saved') do
      User.create
      User.create(name: 'Kyle')
      User.create(base_lang: 1)
    end
    assert_difference(call, 1, 'should have saved') do
      User.create(name: 'Kyle', base_lang: 1)
      User.create(name: 'Kyle', base_lang: 1)
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

  test 'User.base_script' do
    template = lang_by_name('English').base_script
    user = User.first
    result = user.base_script
    assert_equal(template, result, 'User.base_script did not work')
  end

  test 'User.base_sentence' do
    user = user_by_name('Luke')
    target_sentence = sentence_by_id(3)
    template = sentence_by_id(2)
    result = user.base_sentence(target_sentence)
    assert_equal(template, result, 'incorrect sentence record returned')

    target_sentence = sentence_by_id(13)
    assert_raises(Invalid, 'Invalid not raised!') do
      user.base_sentence(target_sentence)
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
end

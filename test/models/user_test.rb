require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'user validations should work' do
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

  test 'user associations should work' do
    user = user_by_name('Luke')
    call = 'user.user_scores.count'
    assert_difference(call, 1, 'score did not save') do
      user.user_scores.create(target_word_id: 14, score: 0.09, status: 'tested')
    end
    call = 'user.user_metrics.count'
    assert_difference(call, 1, 'score did not save') do
      user.user_metrics.create(target_word_id: 14, target_sentence_id: 9,
                               speed: 40, pause: false, hover: true,
                               hide: false)
    end
  end
end

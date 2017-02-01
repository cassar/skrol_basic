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
    call = 'user.user_maps.count'
    UserMap.first.destroy
    assert_difference(call, 1, 'map did not save') do
      user.user_maps.create(rank_num: 1, lang_map_id: 1)
    end
  end
end

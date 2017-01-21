require 'test_helper'

class UserMapTest < ActiveSupport::TestCase
  test 'User association and validations' do
    luke = user_by_name('Luke')
    lang_map = LangMap.first
    call = 'UserMap.count'
    assert_difference(call, 2, 'incorrect # of user maps saved') do
      luke.user_maps.create(lang_map_id: 2, rank_num: 1)
      luke.user_maps.create(lang_map_id: lang_map.id, rank_num: 1)
      luke.user_maps.create(lang_map_id: lang_map.id)
      luke.user_maps.create(lang_map_id: 3, rank_num: 1)
    end
    user_map = UserMap.first
    assert_equal(luke, user_map.user, 'User record did not return')
    assert_equal(lang_map, user_map.lang_map, 'Lang_map record did not return')
  end
end

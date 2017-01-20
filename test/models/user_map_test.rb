require 'test_helper'

class UserMapTest < ActiveSupport::TestCase
  test 'User association and validations' do
    luke = user_by_name('Luke')
    call = 'UserMap.count'
    result = nil
    assert_difference(call, 2, 'incorrect # of user maps saved') do
      result = luke.user_maps.create(base_lang: 1, target_lang: 3, rank_num: 1)
      luke.user_maps.create(base_lang: 1, target_lang: 3, rank_num: 1)
      luke.user_maps.create(base_lang: 1, target_lang: 2)
      luke.user_maps.create(base_lang: 1, target_lang: 2, rank_num: 1)
    end
    assert_equal(luke, result.user, 'User record did not return')
  end
end

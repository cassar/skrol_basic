require 'test_helper'

class MapTest < ActiveSupport::TestCase
  test 'map validations' do
    call = 'Map.count'
    assert_difference(call, 2, 'incorrect # of maps saved') do
      Map.create(base_lang: 1, target_lang: 3)
      Map.create(base_lang: 1, target_lang: 3)
      Map.create(base_lang: 3, target_lang: 1)
      Map.create(base_lang: 3)
    end
  end
end

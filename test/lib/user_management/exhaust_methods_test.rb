require 'test_helper'

class ExhaustMethodsTest < ActiveSupport::TestCase
  test 'average_exhaust' do
    word = word_by_id(3)
    result = average_exhaust(word)
    template = 1.0 / 3
    assert_equal(template, result, 'incorrect average_exhaust returned')
  end

  test 'user_exhaust' do
    word = word_by_id(3)
    user_map = UserMap.first
    result = user_exhaust(user_map, word)
    template = 1.0 / 3
    assert_equal(template, result, 'incorrect user_exhaust returned')
  end

  test 'related_metrics' do
  end

  test 'populate_exhaust_catalouge' do
  end

  test 'return_user_exhaust' do
  end
end

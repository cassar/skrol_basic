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
    user = user_by_name('Luke')
    result = user_exhaust(user, word)
    template = 1.0 / 3
    assert_equal(template, result, 'incorrect user_exhaust returned')
  end
end

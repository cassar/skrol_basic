require 'test_helper'

class ExhaustMethodsTest < ActiveSupport::TestCase
  test 'average_exhaust' do
    word = Word.find(3)
    result = average_exhaust(word)
    template = 1.0 / 3
    assert_equal(template, result, 'incorrect average_exhaust returned')
  end

  test 'user_exhaust' do
    word = Word.find(3)
    enrolment = Enrolment.first
    result = user_exhaust(enrolment, word)
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

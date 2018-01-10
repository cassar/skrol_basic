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
  end

  test 'User.current_name' do
  end
end

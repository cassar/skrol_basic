require 'test_helper'

class UserTest < ActiveSupport::TestCase
  test 'create_student' do
    assert_difference('Student.count', 1) do
      user = User.create(name: 'Luke')
    end
  end
end

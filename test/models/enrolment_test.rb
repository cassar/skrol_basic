require 'test_helper'

class EnrolmentTest < ActiveSupport::TestCase
  setup do
    @enrolment = Enrolment.find(1)
    @course = Course.find(1)
  end

  test 'info' do
    @enrolment.info
  end

  test 'destroy' do
    assert_difference('UserMetric.count', -3) do
      @enrolment.reset
    end
  end
end

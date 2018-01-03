require 'test_helper'

class NextSlideRetrieverTest < ActiveSupport::TestCase
  setup do
    UserMetric.destroy_all
    @enrolment = Enrolment.find(1)
  end

  test 'retrieve' do
    puts NextSlideRetriever.retrieve(@enrolment)
  end
end

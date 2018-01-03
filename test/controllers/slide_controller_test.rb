require 'test_helper'

class SlideControllerTest < ActionDispatch::IntegrationTest
  test 'send_slide' do
    lang_map = LanguageMap.first

    # get '/slides'
    # assert_equal(@response.body, @response.body, 'incorrect object returned')
  end

  test 'recieve_metrics' do
  end

  test 'reset_user_session' do
  end
end

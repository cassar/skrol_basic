require 'test_helper'

class SlideControllerTest < ActionDispatch::IntegrationTest
  test 'send_slide' do
    lang_map = LangMap.first
    setup_map(lang_map)

    # get '/slides'
    # assert_equal(@response.body, @response.body, 'incorrect object returned')
  end

  test 'recieve_metrics' do
  end

  test 'reset_user_session' do
  end
end

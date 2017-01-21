require 'test_helper'

class SlideControllerTest < ActionDispatch::IntegrationTest
  test 'show' do
    lang_map = LangMap.first
    setup_map(lang_map)

    get '/slides/1'
    assert_equal(@response.body, @response.body, 'incorrect object returned')
  end
end

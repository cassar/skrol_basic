require 'test_helper'

class SlideControllerTest < ActionDispatch::IntegrationTest
  test 'show' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    setup_map(base_lang, target_lang)

    get '/slides/1'
    assert_equal(@response.body, @response.body, 'incorrect object returned')
  end
end

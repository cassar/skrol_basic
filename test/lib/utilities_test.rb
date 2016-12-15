require 'test_helper'

class UtilitiesTest < ActiveSupport::TestCase
  test 'max_word_length should work as advertised' do
    script = lang_by_name('English').base_script

    assert_equal(7, max_word_length(script), 'max method not working')
  end

  test 'lang_by_name should work as advertised' do
    assert_not_nil(lang_by_name('English'), 'Failed to retrieve English.')
    assert_raises(Invalid, 'Did not raises Invalid') do
      lang_by_name('Jibberish')
    end
  end
end

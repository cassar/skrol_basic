require 'test_helper'

class UtilitiesTest < ActiveSupport::TestCase
  test 'max_word_length' do
    script = lang_by_name('English').standard_script

    assert_equal(7, max_word_length(script), 'max method not working')
  end
end

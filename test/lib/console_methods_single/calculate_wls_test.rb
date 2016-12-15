require 'test_helper'

class CalculateWLSTest < ActiveSupport::TestCase
  test 'calculate_wls should work as advertised' do
    script = lang_by_name('English').base_script
    word = script.words.where(entry: 'bottle').first
    script.words.create(entry: 'neighbor')
    script.words.create(entry: 'top')

    result = calculate_wls(word)
    template = (8 - 6) / 8.0
    assert_equal(template, result, 'wrong wls calculated')
  end
end

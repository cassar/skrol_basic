require 'test_helper'

class CalculateWLSTest < ActiveSupport::TestCase
  test 'calculate_wls' do
    script = Language.find_by_name('English').standard_script
    word = script.words.find_by_entry('bottle')
    script.words.create(entry: 'neighbor')
    script.words.create(entry: 'top')

    result = calculate_wls(word)
    template = (8 - 6) / 8.0
    assert_equal(template, result, 'wrong wls calculated')
  end
end

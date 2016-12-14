require 'test_helper'

class CalculateWLSTest < ActiveSupport::TestCase
  test 'calculate_wls should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle')
    script.words.create(entry: 'neighbor')
    script.words.create(entry: 'top')

    result = calculate_wls(word)
    template = (8 - 6) / 8.0
    assert_equal(template, result, 'wrong wls calculated')
  end
end

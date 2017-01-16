require 'test_helper'

class RegexTest < ActiveSupport::TestCase
  test 'Regex validation' do
    script = Script.first
    template = nil
    assert_difference('Regex.count', 1, 'incorrect saved') do
      Regex.create(entry: '.')
      template = script.regexes.create(entry: '.')
    end
    result = script.regexes.first
    assert_equal(template, result, 'incorrect script returned')
  end
end

require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test 'Language.create should only accept complete entries.' do
    Language.create
    Language.create(name: 'Latin script (English alphabet)')

    assert_equal(1, Language.count, 'Incorrect # of records saved.')
  end
end

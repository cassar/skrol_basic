require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test 'Language.create should only accept complete entries.' do
    Language.create
    Language.create(name: 'English')

    assert_equal(1, Language.count, 'Incorrect # of records saved.')
  end

  test 'Language.scripts.create creates a script' do
    lang = Language.create(name: 'English')
    lang.scripts.create(name: 'Latin script (English alphabet)')

    script = Script.where(language_id: 1)
    assert_not_nil(script, 'Script not saved!')

    assert_equal(1, lang.scripts.count, "lang.scripts doesn't work")
  end
end

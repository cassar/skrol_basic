require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test 'Language.create should only accept complete entries.' do
    Language.create
    Language.create(name: 'English')

    assert_equal(1, Language.count, 'Incorrect # of records saved.')
  end

  test 'Language.scripts.others.create creates a script.others' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin script (English alphabet)')
    script.characters.create(entry: 'a')

    script = Script.where(language_id: 1)
    assert_not_nil(script, 'Script not saved!')

    assert_equal(1, lang.scripts.count, "lang.scripts doesn't work")
    assert_equal(1, lang.characters.count, "lang.characters doesn't work")
  end
end

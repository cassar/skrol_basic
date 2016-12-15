require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test 'Language.create should only accept complete entries.' do
    eval = 'Language.count'

    assert_difference(eval, difference = 0, 'Record should not have saved') do
      Language.create
    end

    assert_difference(eval, difference = 1, 'Record should have saved') do
      Language.create(name: 'Chinese')
    end

    assert_difference(eval, difference = 0, 'Record should not have saved') do
      Language.create(name: 'Chinese')
    end
  end

  test 'Language.scripts.others.create creates a script.others' do
    lang = Language.create(name: 'Greek')
    script = lang.scripts.create(name: 'Greek')

    script = Script.where(name: 'Greek').first
    assert_not_nil(script, 'Script not saved!')

    assert_equal(1, lang.scripts.count, "lang.scripts doesn't work")
    assert_equal(0, lang.characters.count, "lang.characters doesn't work")
    assert_equal(0, lang.words.count, "lang.words doesn't work")
    assert_equal(0, lang.sentences.count, "lang.sentences doesn't work")
  end
end

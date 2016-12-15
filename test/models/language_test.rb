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
    phonetic = script.create_phonetic('IPA')

    assert_equal(script, lang.base_script, "base_script doesn't work")
    assert_equal(phonetic, lang.phonetic_script, "phonetic_script don't work")
    script = Script.where(name: 'Greek').first
    assert_not_nil(script, 'Script not saved!')

    assert_equal(2, lang.scripts.count, "lang.scripts doesn't work")
    assert_equal(0, lang.characters.count, "lang.characters doesn't work")
    assert_equal(0, lang.words.count, "lang.words doesn't work")
    assert_equal(0, lang.sentences.count, "lang.sentences doesn't work")

    lang = Language.create(name: 'Jibberish')
    assert_raises(Invalid) { lang.base_script }
    assert_raises(Invalid) { lang.phonetic_script }
  end
end

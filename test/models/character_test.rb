require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  test 'Character.create should only save complete entries' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin script (English alphabet)')
    char = script.characters.create(entry: 'a')
    script.characters.create

    assert_equal(1, Character.count, 'Wrong number of characters saved!')
    assert_not_nil(char.script, '.script method does not work.')
    assert_not_nil(char.language, '.language method does not work.')
  end
end

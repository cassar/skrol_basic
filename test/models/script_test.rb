require 'test_helper'

class ScriptTest < ActiveSupport::TestCase
  test 'Script.create should only save whole entries' do
    lang = Language.create(name: 'Romanian')
    eval = 'Script.count'

    assert_difference(eval, difference = 0, 'Record should not have saved') do
      lang.scripts.create
    end

    assert_difference(eval, difference = 1, 'Record should have saved') do
      lang.scripts.create(name: 'Latin')
    end

    assert_difference(eval, difference = 0, 'Record should not have saved') do
      lang.scripts.create(name: 'Latin')
    end
  end

  test 'Script.phonetic methods should work.' do
    lang = Language.create(name: 'Romanian')
    b_script = lang.scripts.create(name: 'Latin')
    eval = 'Script.count'

    assert_difference(eval, difference = 1, 'Record should have saved') do
      b_script.create_phonetic('IPA')
    end
  end
end

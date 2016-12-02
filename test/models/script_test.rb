require 'test_helper'

class ScriptTest < ActiveSupport::TestCase
  test 'Script.create should only save whole entries' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin script (English alphabet)')
    lang.scripts.create

    assert_equal(1, Script.count, 'Wrong # of Scripts saved.')
    assert_not_nil(script.language, 'script.language method not working.')
  end
end

require 'test_helper'

class ScriptTest < ActiveSupport::TestCase
  test 'Script.create should only save whole entries' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.create(name: 'Latin script (English alphabet)')
    lang.scripts.create(name: 'Latin script (English alphabet)')
    lang.scripts.create

    assert_equal(1, Script.count, 'Wrong # of Scripts saved.')
    assert_not_nil(script.language, 'script.language method not working.')
  end

  test 'Script.phonetic methods should work.' do
    lang = Language.where(name: 'English').first
    b_script = lang.scripts.create(name: 'Latin script (English alphabet)')

    p_script = b_script.create_phonetic('IPA')

    assert_not_nil(p_script, 'phonetic script failed to save.')
    assert_equal(2, Script.count, 'Wrong number of scripts saved.')

    assert_equal(p_script, b_script.phonetic, '.phonetic method not working.')
  end
end

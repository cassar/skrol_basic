require 'test_helper'

class ScriptTest < ActiveSupport::TestCase
  test 'Script.create' do
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

  test 'Script.phonetic' do
    lang = Language.create(name: 'Romanian')
    b_script = lang.scripts.create(name: 'Latin')
    eval = 'Script.count'
    p_script = nil

    assert_difference(eval, difference = 1, 'Record should have saved') do
      p_script = b_script.create_phonetic('IPA')
    end

    assert_raises(ActiveRecord::RecordNotFound, 'Invalid not raised') do
      p_script.phonetic
    end
  end

  test 'Script.base' do
    phon = Script.where(id: 2).first
    base = Script.where(id: 1).first
    assert_equal(base, phon.base, 'incorrect script returnd')
    assert_raises(ActiveRecord::RecordNotFound, 'Invalid should have raised') do
      base.base
    end
  end

  test 'Script.word_by_entry' do
    script = lang_by_name('English').base_script
    assert_not_nil(script.word_by_entry('hello'), 'word_by_entry does not work')

    assert_raises(ActiveRecord::RecordNotFound, 'Invalid should have raised') do
      script.word_by_entry('test')
    end
  end

  test 'Script.corresponding' do
  end
end

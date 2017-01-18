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

    assert_raises(Invalid, 'Invalid not raised') { p_script.phonetic }
  end

  test 'Script.base' do
    phon = Script.where(id: 2).first
    base = Script.where(id: 1).first
    assert_equal(base, phon.base, 'incorrect script returnd')
    assert_raises(Invalid, 'Invalid should have been raised') { base.base }
  end

  test 'Script.word_by_entry' do
    script = lang_by_name('English').base_script
    assert_not_nil(script.word_by_entry('hello'), 'word_by_entry does not work')
  end

  test 'Script.corresponding' do
  end

  test 'Script.retrieve_all_wts' do
    base_script = lang_by_name('English').base_script

    compile_chars_cfs(base_script)
    compile_chars_cfs(base_script.phonetic)
    compile_wfs_script(base_script)
    compile_wls_script(base_script)

    target_script = lang_by_name('Spanish').base_script

    compile_chars_cfs(target_script)
    compile_chars_cfs(target_script.phonetic)
    compile_wfs_script(target_script)
    compile_wls_script(target_script)

    target_script.words.each { |word| compile_wts(word, base_script) }
    scores = Score.where(name: 'WTS', map_to_id: base_script.id).count
    result = target_script.retrieve_all_wts(base_script).count
    assert_equal(scores, result, 'retrieve did not work')

    target_script = lang_by_name('German').base_script
    assert_raises(Invalid, 'Invalid not raised') do
      target_script.retrieve_all_wts(base_script)
    end
  end
end

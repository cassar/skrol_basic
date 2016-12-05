require 'test_helper'

class CalculateCFILSTest < ActiveSupport::TestCase
  test 'calculate_cfils should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    script1.characters.create(entry: 'a')
    script1.characters.create(entry: 'b')

    lang1 = Language.create(name: 'Italian')
    script1 = lang.scripts.create(name: 'Latin')
    script1.words.create(entry: 'bueno')
    script1.characters.create(entry: 'b')
    script1.characters.create(entry: 'u')

    assert_equal(2, score.count, 'Wrong number of scores saved')

  end

  test 'clear_old_cfils_scores should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    char = script.characters.create(entry: 'h')

    lang1 = Language.create(name: 'Italian')
    script1 = lang.scripts.create(name: 'Latin')

    char.scores.create(map_to_id: script1.id, map_to_type: 'scripts',
                       score_name: 'CFILS')
    assert_equal(1, Score.count, 'CFILS score failed to save')

    clear_old_cfils_scores(script, script1)
    assert_equal(0, Score.count, 'CFILS score failed to delete')
  end

  test 'calculate_total_chars should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')

    total = calculate_total_chars(script)
    assert_equal(0, total, 'No chars should have been saved!')

    script.words.create(entry: 'hello')
    script.words.create(entry: 'cow')

    total = calculate_total_chars(script)
    assert_equal(8, total, 'Wrong number of chars saved!')
  end

  test 'check_all_chars should should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    script.characters.create(entry: 'h')
    lang1 = Language.create(name: 'Italian')
    script1 = lang.scripts.create(name: 'Latin')

    assert_raises(Invalid) { check_all_chars(script, script1) }
    assert_raises(Invalid) { check_all_chars(script1, script) }

    script1.characters.create(entry: 'h')
    assert_same(true, check_all_chars(script1, script))
  end

  test 'check_avail_chars should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    assert_same(false, check_avail_chars(script))
    script.characters.create(entry: 'h')
    assert_same(true, check_avail_chars(script))
  end
end

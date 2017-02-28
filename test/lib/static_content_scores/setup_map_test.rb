require 'test_helper'

class SetupMapTest < ActiveSupport::TestCase
  test 'setup_map' do
    lang_map = LangMap.first
    setup_map(lang_map)

    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')

    char_count = base_lang.characters.count + target_lang.characters.count
    word_count = target_lang.base_script.words.count
    sentence_count = target_lang.base_script.sentences.count
    total_count = char_count + word_count * 3 + sentence_count * 2
    actual_count = Score.count - Score.where(name: 'REP').count
    assert_equal(total_count, actual_count, 'incorrect # of scores saved')
  end

  test 'establish_chars' do
    lang_map = LangMap.first
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')

    establish_chars(lang_map)
    template = base_lang.characters.count + target_lang.characters.count
    score_count = Score.where(name: 'CFS').count
    assert_equal(template, score_count, 'wrong number of CFS saved')
  end

  test 'map_wts' do
    lang_map = LangMap.first
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')

    establish_chars(lang_map)
    target_script = target_lang.base_script
    compile_wfs_script(target_script)
    compile_wls_script(target_script)

    map_wts(lang_map)
    count = target_lang.base_script.words.count
    wts_count = Score.where(name: 'WTS').count
    assert_equal(count, wts_count, 'wrong number of score saved')
  end

  test 'map_sts' do
    lang_map = LangMap.first
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')

    establish_chars(lang_map)
    target_script = target_lang.base_script
    base_script = base_lang.base_script
    compile_wfs_script(target_script)
    compile_wls_script(target_script)

    target_script.words.each { |word| compile_wts(word, base_script, lang_map) }
    compile_swls(target_script)

    map_sts(lang_map)

    count = target_lang.base_script.sentences.count
    sts_count = Score.where(name: 'STS').count
    assert_equal(count, sts_count, 'wrong number of score saved')
  end
end

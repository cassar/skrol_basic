require 'test_helper'

class SetupMapTest < ActiveSupport::TestCase
  test 'setup_map' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    setup_map(base_lang, target_lang)

    char_count = base_lang.characters.count + target_lang.characters.count
    word_count = target_lang.base_script.words.count
    sentence_count = target_lang.base_script.sentences.count
    total_count = char_count + word_count * 3 + sentence_count * 2
    assert_equal(total_count, Score.count, 'incorrect # of scores saved')
  end

  test 'establish_chars' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')

    establish_chars(base_lang, target_lang)
    template = base_lang.characters.count + target_lang.characters.count
    score_count = Score.where(name: 'CFS').count
    assert_equal(template, score_count, 'wrong number of CFS saved')
  end

  test 'map_wts' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')

    establish_chars(base_lang, target_lang)
    target_script = target_lang.base_script
    compile_wfs_script(target_script)
    compile_wls_script(target_script)

    map_wts(base_lang, target_lang)
    count = target_lang.base_script.words.count
    wts_count = Score.where(name: 'WTS').count
    assert_equal(count, wts_count, 'wrong number of score saved')
  end

  test 'map_sts' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')

    establish_chars(base_lang, target_lang)
    target_script = target_lang.base_script
    base_script = base_lang.base_script
    compile_wfs_script(target_script)
    compile_wls_script(target_script)

    target_script.words.each { |word| compile_wts(word, base_script) }
    compile_swls(target_script)

    map_sts(base_lang, target_lang)

    count = target_lang.base_script.sentences.count
    sts_count = Score.where(name: 'STS').count
    assert_equal(count, sts_count, 'wrong number of score saved')
  end
end

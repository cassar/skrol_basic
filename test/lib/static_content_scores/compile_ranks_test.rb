require 'test_helper'

class CompileRanksTest < ActiveSupport::TestCase
  test 'compile_word_ranks' do
    Rank.destroy_all
    lang_map = LangMap.first
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')

    establish_chars(lang_map)
    target_script = target_lang.base_script
    compile_wfs_script(target_script)
    compile_wls_script(target_script)

    map_wts(lang_map)
    change = lang_map.target_script.words.count
    call = 'Rank.count'
    assert_difference(call, change, 'incorrect # of Ranks saved') do
      compile_word_ranks(lang_map)
    end
  end

  test 'assign_word_ranks' do
  end

  test 'compile_sentence_ranks' do
    Rank.destroy_all
    RepSent.destroy_all
    lang_map = LangMap.first
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')

    establish_chars(lang_map)
    target_script = target_lang.base_script
    compile_wfs_script(target_script)
    compile_wls_script(target_script)
    compile_reps(target_script)
    map_wts(lang_map)
    compile_word_ranks(lang_map)
    compile_swls(target_script)
    map_sts(lang_map)

    call = "Rank.where(lang_map_id: #{lang_map.id}).count"
    expect = RepSent.count
    assert_difference(call, expect, 'incorrect sentence_ranks saved') do
      compile_sentence_ranks(lang_map)
    end
  end

  test 'process_sent_id' do
    rep_sent = RepSent.first
    lang_map = LangMap.first
    scores_arr = []
    scores_obj = {}
    assert_difference('scores_arr.length', 1, 'scores_arr did not increase') do
      process_sent_id(rep_sent, lang_map, scores_arr, scores_obj)
    end
    assert_equal(rep_sent, scores_obj[0.345], 'repsent record not returned')
  end

  test 'assign_sentence_ranks' do
    Rank.destroy_all
    scores_arr = [0.1]
    scores_obj = { 0.1 => RepSent.first }
    lang_map = LangMap.first
    call = 'Rank.count'
    assert_difference(call, 1, 'rank did not save') do
      assign_sentence_ranks(scores_arr, scores_obj, lang_map)
    end
  end
end

require 'test_helper'

class CompileRanksTest < ActiveSupport::TestCase
  test 'compile_ranks' do
    Rank.all.each(&:destroy)
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
      compile_ranks(lang_map)
    end
  end

  test 'assign_ranks' do
  end
end

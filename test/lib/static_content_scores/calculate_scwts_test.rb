require 'test_helper'

class CalculateSCWTSTest < ActiveSupport::TestCase
  test 'compile_scwts' do
  end

  test 'calculate_scwts' do
    base_script = lang_by_name('English').base_script

    compile_chars_cfs(base_script)
    compile_chars_cfs(base_script.phonetic)
    compile_wfs_script(base_script)
    compile_wls_script(base_script)

    script = lang_by_name('Spanish').base_script
    target_sentence =
      script.sentences.where(entry: 'El coche es de color azul!').first

    compile_chars_cfs(script)
    compile_chars_cfs(script.phonetic)
    compile_wfs_script(script)
    compile_wls_script(script)

    lang_map = LangMap.first

    script.words.each { |word| compile_wts(word, lang_map) }
    compile_swls(script)

    result = calculate_scwts(target_sentence, lang_map)
    assert(result.is_a?(Float), 'incorrect scwts returned')
  end

  test 'retrieve_wts_score' do
    script = lang_by_name('English').base_script

    compile_chars_cfs(script)
    compile_chars_cfs(script.phonetic)
    compile_wfs_script(script)
    compile_wls_script(script)

    script2 = lang_by_name('Italian').base_script

    compile_chars_cfs(script2)
    compile_chars_cfs(script2.phonetic)
    compile_wfs_script(script2)
    compile_wls_script(script2)

    lang_map = LangMap.first

    script2.words.each { |word| compile_wts(word, lang_map) }
    compile_swls(script2)

    result = retrieve_wts_score('bottiglia', lang_map)
    assert(result.is_a?(Float), 'incorrect wts score returned')
  end
end

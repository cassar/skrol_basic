require 'test_helper'

class CalculateSCWTSTest < ActiveSupport::TestCase
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

    script.words.each { |word| compile_wts(word, base_script) }
    compile_swls(script)

    result = calculate_scwts(target_sentence, base_script)
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

    script2.words.each { |word| compile_wts(word, script) }
    compile_swls(script2)

    result = retrieve_wts_score('bottiglia', script2, script)
    assert(result.is_a?(Float), 'incorrect wts score returned')
  end
end

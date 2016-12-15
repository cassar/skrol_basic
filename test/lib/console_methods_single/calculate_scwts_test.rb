require 'test_helper'

class CalculateSCWTSTest < ActiveSupport::TestCase
  test 'calculate_scwts works as advertised' do
    base_script = lang_by_name('English').base_script
    compile_chars_cfs(base_script)
    compile_chars_cfs(base_script.phonetic)

    script = lang_by_name('Spanish').base_script
    target_sentence =
      script.sentences.where(entry: 'El coche es de color azul!').first
    compile_chars_cfs(script)
    compile_chars_cfs(script.phonetic)

    result = calculate_scwts(target_sentence, base_script)
    template = 0.1661015673284192
    assert_equal(template, result, 'incorrect scwts returned')
  end

  test 'retrieve_wts_score works as advertised' do
    script = lang_by_name('English').base_script
    compile_chars_cfs(script)
    compile_chars_cfs(script.phonetic)

    script2 = lang_by_name('Italian').base_script
    compile_chars_cfs(script2)
    compile_chars_cfs(script2.phonetic)

    result = retrieve_wts_score('bottiglia', script2, script)
    template = 0.1816739587572921
    assert_equal(template, result, 'incorrect wts score returned')
  end
end

require 'test_helper'

class CalculateSCWTSTest < ActiveSupport::TestCase
  test 'calculate_scwts works as advertised' do
    base_script = lang_by_name('English').base_script
    compile_chars_cfs(base_script)

    script = lang_by_name('Spanish').base_script
    target_sentence =
      script.sentences.where(entry: 'El coche es de color azul!').first
    compile_chars_cfs(script)

    result = calculate_scwts(target_sentence, base_script)
    template = 0.25628851540616243
    assert_equal(template, result, 'incorrect scwts returned')
  end

  test 'retrieve_wts_score works as advertised' do
    script = lang_by_name('English').base_script
    compile_chars_cfs(script)

    script2 = lang_by_name('Italian').base_script
    compile_chars_cfs(script2)

    result = retrieve_wts_score('crollare', script2, script)
    template = 0.26548202614379085
    assert_equal(template, result, 'incorrect wts score returned')
  end
end

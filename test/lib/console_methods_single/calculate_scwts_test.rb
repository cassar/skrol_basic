require 'test_helper'

class CalculateSCWTSTest < ActiveSupport::TestCase
  test 'calculate_scwts works as advertised' do
    lang = Language.where(name: 'English').first
    base_script = lang.scripts.where(name: 'Latin').first
    compile_chars_cfs(base_script)

    lang = Language.where(name: 'Spanish').first
    script = lang.scripts.where(name: 'Latin').first
    target_sentence =
      script.sentences.where(entry: 'El coche es de color azul!').first
    compile_chars_cfs(script)

    result = calculate_scwts(target_sentence, base_script)
    template = 0.25628851540616243
    assert_equal(template, result, 'incorrect scwts returned')
  end

  test 'retrieve_wts_score works as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    compile_chars_cfs(script)

    lang2 = Language.where(name: 'Italian').first
    script2 = lang2.scripts.where(name: 'Latin').first
    compile_chars_cfs(script2)

    result = retrieve_wts_score('crollare', script2, script)
    template = 0.26548202614379085
    assert_equal(template, result, 'incorrect wts score returned')
  end
end

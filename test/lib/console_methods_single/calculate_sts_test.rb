require 'test_helper'

class CalculateSTSTest < ActiveSupport::TestCase
  test 'calculate_sts works as advertised' do
    base_script = lang_by_name('English').base_script
    base_script.sentences.where(entry: 'The car is not blue!').first
    compile_chars_cfs(base_script)

    script = lang_by_name('Spanish').base_script
    target_sentence =
      script.sentences.where(entry: 'El coche es de color azul!').first
    compile_chars_cfs(script)

    result = calculate_sts(target_sentence, base_script)
    assert_equal(0.30457521008403365, result, 'incorrect sts score returned')
  end

  test 'return_sentence_scores works as advertised' do
    base_script = lang_by_name('English').base_script
    compile_chars_cfs(base_script)

    script = lang_by_name('Spanish').base_script
    target_sentence =
      script.sentences.where(entry: 'El coche es de color azul!').first
    compile_chars_cfs(script)

    template = [0.25628851540616243, 0.0, 0.6666666666666667]
    result = return_sentence_scores(target_sentence, base_script)
    assert_equal(template, result, 'incorrect scores array returned')
  end
end

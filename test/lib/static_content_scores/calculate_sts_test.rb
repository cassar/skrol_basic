require 'test_helper'

class CalculateSTSTest < ActiveSupport::TestCase
  test 'compile_sts' do
    base_script = lang_by_name('English').base_script
    compile_chars_cfs(base_script)
    compile_chars_cfs(base_script.phonetic)

    script = lang_by_name('Spanish').base_script
    target_sentence = sentence_by_id(3)
    compile_chars_cfs(script)
    compile_chars_cfs(script.phonetic)

    compile_sts(target_sentence, base_script)

    result = target_sentence.retrieve_sts(base_script)
    assert_equal(0.273631124986594, result.entry, 'incorrect score returned')
    assert_equal(1, target_sentence.scores.count, 'old score was not removed')
  end

  test 'calculate_sts' do
    base_script = lang_by_name('English').base_script
    base_script.sentences.where(entry: 'The car is not blue!').first
    compile_chars_cfs(base_script)
    compile_chars_cfs(base_script.phonetic)

    script = lang_by_name('Spanish').base_script
    target_sentence =
      script.sentences.where(entry: 'El coche es de color azul!').first
    compile_chars_cfs(script)
    compile_chars_cfs(script.phonetic)

    result = calculate_sts(target_sentence, base_script)
    assert_equal(0.27363112498659375, result, 'incorrect sts score returned')
  end

  test 'return_sentence_scores' do
    base_script = lang_by_name('English').base_script
    compile_chars_cfs(base_script)
    compile_chars_cfs(base_script.phonetic)

    script = lang_by_name('Spanish').base_script
    target_sentence =
      script.sentences.where(entry: 'El coche es de color azul!').first
    compile_chars_cfs(script)
    compile_chars_cfs(script.phonetic)

    template = [0.1625185605654356, 0.0, 0.6666666666666667]
    result = return_sentence_scores(target_sentence, base_script)
    assert_equal(template, result, 'incorrect scores array returned')
  end
end

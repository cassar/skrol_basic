require 'test_helper'

class CalculateSTSTest < ActiveSupport::TestCase
  test 'calculate_sts works as advertised' do
    lang = Language.where(name: 'English').first
    base_script = lang.scripts.create(name: 'Latin')
    sentence = base_script.sentences.create(entry: 'The car is blue!', group_id: 1)
    base_script.sentences.create(entry: 'The car is not blue!', group_id: 2)
    word = base_script.words.create(entry: 'The', group_id: 1)
    word2 = base_script.words.create(entry: 'car', group_id: 2)
    word3 = base_script.words.create(entry: 'is', group_id: 3)
    word4 = base_script.words.create(entry: 'blue', group_id: 4)
    base_script.words.create(entry: 'blue', group_id: 5)
    compile_chars_cfs(base_script)

    lang = Language.create(name: 'Spanish')
    script = lang.scripts.create(name: 'Latin')
    target_sentence = script.sentences.create(entry: 'El coche es de color azul!', group_id: 1)
    script.sentences.create(entry: 'El coche no es azul', group_id: 2)
    word5 = script.words.create(entry: 'el', group_id: 1)
    word6 = script.words.create(entry: 'coche', group_id: 2)
    word7 = script.words.create(entry: 'es', group_id: 3)
    word8 = script.words.create(entry: 'de')
    word9 = script.words.create(entry: 'color')
    word9 = script.words.create(entry: 'no', group_id: 5)
    word10 = script.words.create(entry: 'azul', group_id: 4)
    compile_chars_cfs(script)

    result = calculate_sts(target_sentence, base_script)
    assert_equal(0.29120520833333335, result, 'incorrect sts score returned')
  end

  test 'return_sentence_scores works as advertised' do
    lang = Language.where(name: 'English').first
    base_script = lang.scripts.create(name: 'Latin')
    sentence = base_script.sentences.create(entry: 'The car is blue!', group_id: 1)
    base_script.sentences.create(entry: 'The car is not blue!', group_id: 2)
    word = base_script.words.create(entry: 'The', group_id: 1)
    word2 = base_script.words.create(entry: 'car', group_id: 2)
    word3 = base_script.words.create(entry: 'is', group_id: 3)
    word4 = base_script.words.create(entry: 'blue', group_id: 4)
    base_script.words.create(entry: 'blue', group_id: 5)
    compile_chars_cfs(base_script)

    lang = Language.create(name: 'Spanish')
    script = lang.scripts.create(name: 'Latin')
    target_sentence = script.sentences.create(entry: 'El coche es de color azul!', group_id: 1)
    script.sentences.create(entry: 'El coche no es azul', group_id: 2)
    word5 = script.words.create(entry: 'el', group_id: 1)
    word6 = script.words.create(entry: 'coche', group_id: 2)
    word7 = script.words.create(entry: 'es', group_id: 3)
    word8 = script.words.create(entry: 'de')
    word9 = script.words.create(entry: 'color')
    word9 = script.words.create(entry: 'no', group_id: 5)
    word10 = script.words.create(entry: 'azul', group_id: 4)
    compile_chars_cfs(script)

    template = [0.21577335858585858, 0.0, 0.6666666666666667]
    result = return_sentence_scores(target_sentence, base_script)
    assert_equal(template, result, 'incorrect scores array returned')
  end
end

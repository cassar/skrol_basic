require 'test_helper'

class CalculateSWOSTest < ActiveSupport::TestCase
  test 'calculate_swos' do
    base_script = lang_by_name('English').base_script

    script = lang_by_name('Spanish').base_script
    target_sentence =
      script.sentences.where(entry: 'El coche es de color azul!').first

    result = calculate_swos(target_sentence, base_script)
    template = (3 + 1.0 / 3) / 5

    assert_equal(template, result, 'incorrect swos calculated')
  end

  test 'return_swos_score' do
    script = lang_by_name('English').base_script
    word = script.word_by_entry('the')
    word2 = script.word_by_entry('car')
    word3 = script.word_by_entry('is')
    word4 = script.word_by_entry('blue')

    script = lang_by_name('Spanish').base_script
    word5 = script.word_by_entry('el')
    word6 = script.word_by_entry('coche')
    word7 = script.word_by_entry('es')
    word8 = script.word_by_entry('de')
    word9 = script.word_by_entry('color')
    word10 = script.word_by_entry('azul')

    base_word_arr = [word, word2, word3, word4]
    target_word_arr = [word5, word6, word7, word8, word9, word10]

    result = return_swos_score(target_word_arr, base_word_arr)
    template = (3 + 1.0 / 3) / 5
    assert_equal(template, result, 'incorrect swos score returned')
  end

  test 'return_candidate_arr' do
    script = lang_by_name('English').base_script
    word = script.word_by_entry('the')
    word2 = script.word_by_entry('car')
    word3 = script.word_by_entry('is')
    word4 = script.word_by_entry('blue')

    script = lang_by_name('Spanish').base_script
    word10 = script.word_by_entry('azul')

    base_word_arr = [word, word2, word3, word4]
    target_word = word10

    template = [2]
    result = return_candidate_arr(base_word_arr, target_word, 5)
    assert_equal(template, result, 'incorrect template returned.')
  end

  test 'return_word_arr' do
    script = lang_by_name('English').base_script
    sentence = script.sentences.where(entry: 'Would paper thin!').first
    word = script.word_by_entry('would')
    word2 = script.word_by_entry('paper')
    word3 = script.word_by_entry('thin')

    template = [word, word2, word3]

    result = return_word_arr(sentence)
    assert_equal(template, result, 'incorrect arr returned')
  end

  test 'retrieve_word' do
    script = lang_by_name('English').base_script
    word = script.word_by_entry('would')

    result = retrieve_word('Would', script)
    assert_equal(word, result, 'incorrect record retrieved')
  end
end

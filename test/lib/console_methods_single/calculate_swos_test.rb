require 'test_helper'

class CalculateSWOSTest < ActiveSupport::TestCase
  test 'calculate_swos should work as advertised' do
    lang = Language.where(name: 'English').first
    base_script = lang.scripts.where(name: 'Latin').first

    lang = Language.where(name: 'Spanish').first
    script = lang.scripts.where(name: 'Latin').first
    target_sentence =
      script.sentences.where(entry: 'El coche es de color azul!').first

    result = calculate_swos(target_sentence, base_script)
    template = (3 + 1.0 / 3) / 5

    assert_equal(template, result, 'incorrect swos calculated')
  end

  test 'return_swos_score should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'the').first
    word2 = script.words.where(entry: 'car').first
    word3 = script.words.where(entry: 'is').first
    word4 = script.words.where(entry: 'blue').first

    lang = Language.where(name: 'Spanish').first
    script = lang.scripts.where(name: 'Latin').first
    word5 = script.words.where(entry: 'el').first
    word6 = script.words.where(entry: 'coche').first
    word7 = script.words.where(entry: 'es').first
    word8 = script.words.where(entry: 'de').first
    word9 = script.words.where(entry: 'color').first
    word10 = script.words.where(entry: 'azul').first

    base_word_arr = [word, word2, word3, word4]
    target_word_arr = [word5, word6, word7, word8, word9, word10]

    result = return_swos_score(target_word_arr, base_word_arr)
    template = (3 + 1.0 / 3) / 5
    assert_equal(template, result, 'incorrect swos score returned')
  end

  test 'return_candidate_arr should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'the').first
    word2 = script.words.where(entry: 'car').first
    word3 = script.words.where(entry: 'is').first
    word4 = script.words.where(entry: 'blue').first

    lang = Language.where(name: 'Spanish').first
    script = lang.scripts.where(name: 'Latin').first
    word10 = script.words.where(entry: 'azul').first

    base_word_arr = [word, word2, word3, word4]
    target_word = word10

    template = [2]
    result = return_candidate_arr(base_word_arr, target_word, 5)
    assert_equal(template, result, 'incorrect template returned.')
  end

  test 'return_word_arr should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    sentence = script.sentences.where(entry: 'Would paper thin!').first
    word = script.words.where(entry: 'would').first
    word2 = script.words.where(entry: 'paper').first
    word3 = script.words.where(entry: 'thin').first

    template = [word, word2, word3]

    result = return_word_arr(sentence)
    assert_equal(template, result, 'incorrect arr returned')
  end

  test 'retrieve_word should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'would').first

    result = retrieve_word('Would', script)
    assert_equal(word, result, 'incorrect record retrieved')
  end
end

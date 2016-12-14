require 'test_helper'

class CalculateSWOSTest < ActiveSupport::TestCase
  test 'calculate_swos should work as advertised' do
    lang = Language.where(name: 'English').first
    base_script = lang.scripts.create(name: 'Latin')
    sentence = base_script.sentences.create(entry: 'The car is blue!')
    word = base_script.words.create(entry: 'The', group_id: 1)
    word2 = base_script.words.create(entry: 'car', group_id: 2)
    word3 = base_script.words.create(entry: 'is', group_id: 3)
    word4 = base_script.words.create(entry: 'blue', group_id: 4)

    lang = Language.create(name: 'Spanish')
    script = lang.scripts.create(name: 'Latin')
    target_sentence = script.sentences.create(entry: 'El coche es de color azul!')
    word5 = script.words.create(entry: 'el', group_id: 1)
    word6 = script.words.create(entry: 'coche', group_id: 2)
    word7 = script.words.create(entry: 'es', group_id: 3)
    word8 = script.words.create(entry: 'de')
    word9 = script.words.create(entry: 'color')
    word10 = script.words.create(entry: 'azul', group_id: 4)

    result = calculate_swos(target_sentence, base_script)
    template = (3 + 1.0 / 3) / 5

    assert_equal(template, result, 'incorrect swos calculated')
  end

  test 'return_swos_score should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.create(name: 'Latin')
    sentence = script.sentences.create(entry: 'The car is blue!')
    word = script.words.create(entry: 'The', group_id: 1)
    word2 = script.words.create(entry: 'car', group_id: 2)
    word3 = script.words.create(entry: 'is', group_id: 3)
    word4 = script.words.create(entry: 'blue', group_id: 4)

    lang = Language.create(name: 'Spanish')
    script = lang.scripts.create(name: 'Latin')
    sentence = script.sentences.create(entry: 'El coche es de color azul!')
    word5 = script.words.create(entry: 'el', group_id: 1)
    word6 = script.words.create(entry: 'coche', group_id: 2)
    word7 = script.words.create(entry: 'es', group_id: 3)
    word8 = script.words.create(entry: 'de')
    word9 = script.words.create(entry: 'color')
    word10 = script.words.create(entry: 'azul', group_id: 4)

    base_word_arr = [word, word2, word3, word4]
    target_word_arr = [word5, word6, word7, word8, word9, word10]

    result = return_swos_score(target_word_arr, base_word_arr)
    template = (3 + 1.0 / 3) / 5
    assert_equal(template, result, 'incorrect swos score returned')
  end

  test 'return_candidate_arr should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.create(name: 'Latin')
    sentence = script.sentences.create(entry: 'The car is blue!')
    word = script.words.create(entry: 'The', group_id: 1)
    word2 = script.words.create(entry: 'car', group_id: 2)
    word3 = script.words.create(entry: 'is', group_id: 3)
    word4 = script.words.create(entry: 'blue', group_id: 4)

    lang = Language.create(name: 'Spanish')
    script = lang.scripts.create(name: 'Latin')
    sentence = script.sentences.create(entry: 'El coche es de color azul!')
    word10 = script.words.create(entry: 'azul', group_id: 4)

    base_word_arr = [word, word2, word3, word4]
    target_word = word10

    template = [2]
    result = return_candidate_arr(base_word_arr, target_word, 5)
    assert_equal(template, result, 'incorrect template returned.')
  end

  test 'return_word_arr should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.create(name: 'Latin')
    sentence = script.sentences.create(entry: 'Would paper thin!')
    word = script.words.create(entry: 'Would')
    word2 = script.words.create(entry: 'paper')
    word3 = script.words.create(entry: 'thin')

    template = [word, word2, word3]

    result = return_word_arr(sentence)
    assert_equal(template, result, 'incorrect arr returned')
  end

  test 'retrieve_word should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'would')
    script.words.create(entry: 'paper')

    result = retrieve_word('Would', script)
    assert_equal(word, result, 'incorrect record retrieved')
  end
end

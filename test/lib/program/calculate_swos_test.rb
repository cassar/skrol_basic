require 'test_helper'

class CalculateSWOSTest < ActiveSupport::TestCase
  test 'calculate_swos' do
    puts 'Test is empty!'
  end

  test 'return_swos_score' do
    script = Language.find_by_name('English').standard_script
    word = script.words.find_by_entry('the').group_id
    word2 = script.words.find_by_entry('car').group_id
    word3 = script.words.find_by_entry('is').group_id
    word4 = script.words.find_by_entry('blue').group_id

    script = Language.find_by_name('Spanish').standard_script
    word5 = script.words.find_by_entry('el').group_id
    word6 = script.words.find_by_entry('coche').group_id
    word7 = script.words.find_by_entry('es').group_id
    word8 = script.words.find_by_entry('de').group_id
    word9 = script.words.find_by_entry('color').group_id
    word10 = script.words.find_by_entry('azul').group_id

    base_word_arr = [word, word2, word3, word4]
    target_word_arr = [word5, word6, word7, word8, word9, word10]

    result = return_swos_score(target_word_arr, base_word_arr)
    template = (3 + 1.0 / 3) / 5
    assert_equal(template, result, 'incorrect swos score returned')
  end

  test 'return_candidate_arr' do
    script = Language.find_by_name('English').standard_script
    word = script.words.find_by_entry('the').group_id
    word2 = script.words.find_by_entry('car').group_id
    word3 = script.words.find_by_entry('is').group_id
    word4 = script.words.find_by_entry('blue').group_id

    script = Language.find_by_name('Spanish').standard_script
    word10 = script.words.find_by_entry('azul').group_id

    base_word_arr = [word, word2, word3, word4]
    target_word = word10

    template = [2]
    result = return_candidate_arr(base_word_arr, target_word, 5)
    assert_equal(template, result, 'incorrect template returned.')
  end
end

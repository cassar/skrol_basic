require 'test_helper'

class CalculateWSSTest < ActiveSupport::TestCase
  test 'compile_wss should work as advertised' do
    script = lang_by_name('English').phonetic_script
    word = script.words.where(entry: 'həˈləʊ̯').first

    script2 = lang_by_name('German').phonetic_script
    word2 = script2.words.where(entry: 'ˈhalo').first

    compile_wss(word, script2)
    assert_equal(0.305555555555556, Score.first.entry, 'incorrect score saved')
  end

  test 'calculate_wss should work as advertised' do
    script = lang_by_name('English').phonetic_script
    word = script.words.where(entry: 'həˈləʊ̯').first

    script2 = lang_by_name('German').phonetic_script
    word2 = script2.words.where(entry: 'ˈhalo').first

    template = 0.3055555555555555
    result = calculate_wss(word, script2)
    assert_equal(template, result, 'incorrect score saved')
  end

  test 'return_score work as advertised' do
    base_char_arr = %w(h e l l o)
    target_char_arr = %w(h a l o)
    result = return_score(base_char_arr, target_char_arr)

    assert_equal(3 / 4.5, result, 'wrong score returned')
  end

  test 'return_base_candidate should work as advertised' do
    template = [0, 1]
    result = return_base_candidate('l', 2, %w(h e l l o))

    assert_equal(template, result, 'wrong base_candidate')
  end

  test 'compile_score_array should work as advertised' do
    candidate_arr = [[1, 2, 3], [1, 0], [2, 2]]
    template = [0.5, 1.0, 1.0 / 3]
    score_array = compile_score_array(candidate_arr)
    assert_equal(template, score_array, 'score_array did not compile correctly')
  end

  test 'compile_wss_score should work as advertised' do
    score_array = [0.25, 1]
    base_char_arr = %w(a b c)
    target_char_arr = %w(a b c)
    score = compile_wss_score(score_array, base_char_arr, target_char_arr)

    assert_equal(1.25 / 3, score, 'incorrect score calculated')
  end
end

require 'test_helper'

class RetrieveNextSlide2Test < ActiveSupport::TestCase
  test 'word_from_scores' do
    target_script = lang_by_name('Spanish').base_script
    user_map = UserMap.first
    template = word_by_id(14)

    result = word_from_scores(user_map, target_script)
    assert_equal(template, result, 'incorrect word returned')

    UserScore.first.update(entry: 0.95)
    result = word_from_scores(user_map, target_script)
    assert_nil(result, 'did not return nil')
  end

  test 'word_from_words' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    user_map = UserMap.first
    setup_map(user_map.lang_map)

    template = word_by_id(18)
    result = word_from_words(user_map)
    assert_equal(template, result, 'incorrect word record returned')
  end

  test 'word_used?' do
    word = word_by_id(14)
    user_map = UserMap.first
    assert(word_used?(word, user_map), 'incorrect bool returned')
    word = word_by_id(13)
    assert_not(word_used?(word, user_map), 'incorrect bool returned')
  end

  test 'sentence_used?' do
    sentence = sentence_by_id(1)
    user_map = UserMap.first
    assert(sentence_used?(sentence, user_map), 'incorrect bool returned')
    sentence = sentence_by_id(2)
    assert_not(sentence_used?(sentence, user_map), 'incorrect bool returned')
  end

  test 'return_word_array' do
    template = [word_by_id(9), word_by_id(10), word_by_id(11), word_by_id(12)]
    result = return_word_array(sentence_by_id(2))
    assert_equal(template, result, 'incorrect word array returned')
  end

  test 'phonetic_arr_from_base_arr' do
    base_arr = [word_by_id(1), word_by_id(7)]
    template = [word_by_id(1).phonetic, word_by_id(7).phonetic]

    result = phonetic_arr_from_base_arr(base_arr)
    assert_equal(template, result, 'incorrect array returned')
  end

  test 'retrieve_sts' do
  end
end

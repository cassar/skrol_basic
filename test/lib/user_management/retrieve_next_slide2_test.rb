require 'test_helper'

class RetrieveNextSlide2Test < ActiveSupport::TestCase
  test 'word_from_scores' do
    user_map = UserMap.first

    template = Word.find(13)
    result = word_from_scores(user_map)
    assert_equal(template, result, 'incorrect word returned')

    UserScore.destroy_all
    result = word_from_scores(user_map)
    assert_nil(result, 'did not return nil')
  end

  test 'word_from_words' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    user_map = UserMap.first
    setup_map(user_map.lang_map)

    template = Word.find(18)
    result = word_from_words(user_map)
    assert_equal(template, result, 'incorrect word record returned')
  end

  test 'return_word_array' do
    template = [Word.find(9), Word.find(10), Word.find(11), Word.find(12)]
    result = return_word_array(Sentence.find(2))
    assert_equal(template, result, 'incorrect word array returned')
  end

  test 'phonetic_arr_from_base_arr' do
    base_arr = [Word.find(1), Word.find(7)]
    template = [Word.find(1).phonetic, Word.find(7).phonetic]

    result = phonetic_arr_from_base_arr(base_arr)
    assert_equal(template, result, 'incorrect array returned')
  end
end

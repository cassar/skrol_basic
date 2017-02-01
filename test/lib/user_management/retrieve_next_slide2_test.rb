require 'test_helper'

class RetrieveNextSlide2Test < ActiveSupport::TestCase
  # test 'assign_sentences' do
  #   slide = {}
  #   target_sentence = sentence_by_id(3)
  #   base_sentence = sentence_by_id(2)
  #   base_script = base_sentence.script
  #   user = user_by_name('Luke')
  #
  #   template = {
  #     target_sentence: target_sentence,
  #     base_sentence: base_sentence,
  #     phonetic_sentence: target_sentence.phonetic
  #   }
  #
  #   assign_sentences(slide, target_sentence, base_script)
  #   assert_equal(template, slide, 'Slide does not match template')
  # end
  #
  # test 'assign_arrays' do
  #   target_sentence = sentence_by_id(3)
  #   base_sentence = sentence_by_id(2)
  #   template = {
  #     target_arr: [word_by_id(13), word_by_id(14), word_by_id(15),
  #                  word_by_id(16), word_by_id(17), word_by_id(18)],
  #     phonetic_arr: [word_by_id(31), word_by_id(32), word_by_id(33),
  #                    word_by_id(34), word_by_id(35), word_by_id(36)],
  #     base_arr: [word_by_id(9), word_by_id(10),
  #                word_by_id(11), word_by_id(12)],
  #     base_sentence: base_sentence
  #   }
  #   slide = { base_sentence: base_sentence }
  #   assign_arrays(slide, target_sentence)
  #   assert_equal(template, slide, 'Slide does not match with template')
  # end

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

    target_script = target_lang.base_script
    base_script = base_lang.base_script
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

require 'test_helper'

class RetrieveNextSlide1Test < ActiveSupport::TestCase
  test 'retrieve_next_slide' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    base_script = base_lang.base_script
    user_map = UserMap.first
    setup_map(user_map.lang_map)

    target_word = word_by_id(14)
    target_sentence = sentence_by_id(9)

    template = return_slide(target_word, target_sentence, base_script)
    result = retrieve_next_slide(user_map)
    assert_equal(template, result, 'incorrect slide returned')
    assert_equal(1, UserScore.count, 'Score should have updated not created')
    assert_equal(3, UserMetric.count, 'Metric should have been created')

    target_script = user_map.lang_map.target_script

    assert_raises(Invalid, 'Invalid did not raise') do
      target_script.words.each { |word| word.destroy unless word.id == 14 }
      user_map.user.user_scores.first.update(entry: 0.95)
      retrieve_next_slide(user_map)
    end
  end

  test 'return_next_available_entries' do
  end

  test 'retrieve_next_word' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    base_script = base_lang.base_script
    user_map = UserMap.first
    setup_map(user_map.lang_map)

    result = retrieve_next_word(user_map)
    template = word_by_id(14)

    assert_equal(template, result, 'incorrect word returned')
  end

  test 'retrieve_next_sentence' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    base_script = base_lang.base_script
    user_map = UserMap.first
    setup_map(user_map.lang_map)

    target_word = word_by_id(13)

    template = sentence_by_id(9)
    result = retrieve_next_sentence(target_word, user_map)
    assert_equal(template, result, 'incorrect sentence retrieved')
  end

  test 'return_slide' do
    target_sentence = sentence_by_id(3)
    target_word = word_by_id(13)
    base_script = lang_by_name('English').base_script
    result = return_slide(target_word, target_sentence, base_script)
    base_sentence = sentence_by_id(2)
    template = {
      representative: target_word,
      target_sentence: target_sentence,
      phonetic_sentence: target_sentence.phonetic,
      base_sentence: base_sentence,
      target_arr: [word_by_id(13), word_by_id(14), word_by_id(15),
                   word_by_id(16), word_by_id(17), word_by_id(18)],
      phonetic_arr: [word_by_id(31), word_by_id(32), word_by_id(33),
                     word_by_id(34), word_by_id(35), word_by_id(36)],
      base_arr: [word_by_id(9), word_by_id(10),
                 word_by_id(11), word_by_id(12)]
    }
    assert_equal(template, result, 'incorrect slide returned')
  end
end

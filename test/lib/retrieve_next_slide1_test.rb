require 'test_helper'

class RetrieveNextSlide1Test < ActiveSupport::TestCase
  test 'retrieve_next_slide' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    setup_map(base_lang, target_lang)

    user = user_by_name('Luke')
    target_script = target_lang.base_script

    target_word = word_by_id(14)
    target_sentence = sentence_by_id(9)

    template = return_slide(target_word, target_sentence, user)
    result = retrieve_next_slide(user, target_script)
    assert_equal(template, result, 'incorrect slide returned')
    assert_equal(1, UserScore.count, 'Score should have updated not created')
    assert_equal(3, UserMetric.count, 'Metric should have been created')

    assert_raises(Invalid, 'Invalid did not raise') do
      target_script.words.each { |word| word.destroy unless word.id == 14 }
      user.user_scores.first.update(entry: 0.95)
      retrieve_next_slide(user, target_script)
    end

    assert_raises(Invalid, 'Invalid did not raise') do
      target_script.sentences.each(&:destroy)
      retrieve_next_slide(user, target_script)
    end
  end

  test 'retrieve_next_word' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    setup_map(base_lang, target_lang)

    user = user_by_name('Luke')
    target_script = target_lang.base_script

    result = retrieve_next_word(user, target_script)
    template = word_by_id(14)

    assert_equal(template, result, 'incorrect word returned')
  end

  test 'retrieve_next_sentence' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    setup_map(base_lang, target_lang)

    user = user_by_name('Luke')
    target_word = word_by_id(13)

    template = sentence_by_id(9)
    result = retrieve_next_sentence(user, target_word)
    assert_equal(template, result, 'incorrect sentence retrieved')
  end

  test 'return_slide' do
    target_sentence = sentence_by_id(3)
    target_word = word_by_id(13)
    user = user_by_name('Luke')
    result = return_slide(target_word, target_sentence, user)
    base_sentence = sentence_by_id(2)
    template = {
      representative: target_word,
      target_sentence: target_sentence,
      base_sentence: base_sentence,
      phonetic_sentence: target_sentence.phonetic,
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

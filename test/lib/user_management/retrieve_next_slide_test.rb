require 'test_helper'

class RetrieveNextSlideTest < ActiveSupport::TestCase
  test 'retrieve_next_slide' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    base_script = base_lang.base_script
    user_map = UserMap.first
    setup_map(user_map.lang_map)

    target_sentence = Sentence.find(9)

    template = return_html_slide(target_sentence, user_map)
    result = retrieve_next_slide(user_map)
    assert_equal(template, result, 'incorrect slide returned')

    target_script = user_map.lang_map.target_script

    assert_raises(Invalid, 'Invalid did not raise') do
      target_script.words.each { |word| word.destroy unless word.id == 14 }
      user_map.user_scores.first.update(entry: 0.95)
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
    template = Word.find(13)

    assert_equal(template, result, 'incorrect word returned')
  end

  test 'retrieve_next_sentence' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    base_script = base_lang.base_script
    user_map = UserMap.first
    setup_map(user_map.lang_map)

    target_word = Word.find(13)

    template = Sentence.find(9)
    result = retrieve_next_sentence(target_word, user_map)
    assert_equal(template, result, 'incorrect sentence retrieved')
  end

  test 'search_rep_sents' do
  end

  test 'return_html_slide' do
  end

  test 'return_div_content' do
  end

  test 'compile_sentences_info' do
  end

  test 'add_record_arrs' do
  end

  test 'compile_sentence_html' do
  end

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

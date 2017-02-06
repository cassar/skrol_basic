require 'test_helper'

class RetrieveNextSlide1Test < ActiveSupport::TestCase
  test 'retrieve_next_slide' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    base_script = base_lang.base_script
    user_map = UserMap.first
    setup_map(user_map.lang_map)

    target_word = Word.find(13)
    target_sentence = Sentence.find(9)

    template = return_html_slide(target_word, target_sentence, user_map)
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
end

require 'test_helper'

class ContentHelperTest < ActiveSupport::TestCase
  test 'content_add_helper' do
    lang_map = LangMap.first

    establish_chars(lang_map)
    target_script = lang_map.target_script
    compile_wfs_script(target_script)
    compile_wls_script(target_script)

    map_wts(lang_map)

    hurdle = 2
    base_script = lang_map.base_script

    content_add_helper(lang_map, hurdle)
  end

  test 'sentences_found_in' do
    word = Word.find(10)
    sentence1 = Sentence.find(2)
    sentence2 = Sentence.find(8)
    template = [sentence1, sentence2]
    result = sentences_found_in(word)
    assert_equal(template, result, 'incorrect array returned')
  end

  test 'word_in_sentence?' do
    sentence = Sentence.find(1)
    word = Word.find(3)
    assert(word_in_sentence?(word, sentence), 'method returned wrong bool')
    word = Word.find(4)
    assert(word_in_sentence?(word, sentence), 'method returned wrong bool')
    word = Word.find(1)
    assert_not(word_in_sentence?(word, sentence), 'method returned wrong bool')
  end

  test 'next_word_below_hurdle' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')

    lang_map = LangMap.first
    establish_chars(lang_map)
    target_script = target_lang.base_script
    compile_wfs_script(target_script)
    compile_wls_script(target_script)

    map_wts(lang_map)

    target_script = lang_by_name('Spanish').base_script
    word_rep_counts = return_word_rep_counts(target_script)
    hurdle = 2
    base_script = lang_by_name('English').base_script
    template = Word.find(16)
    result = next_word_below_hurdle(word_rep_counts, hurdle, lang_map)
    assert_equal(template, result, 'Incorrect word returned')
  end
end

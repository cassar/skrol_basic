require 'test_helper'

class CreateContentTest < ActiveSupport::TestCase
  test 'create_word' do
    base_entry = 'tower'
    phonetic_entry = 'ˈtaʊ.ɚ'
    base_script = lang_by_name('English').base_script
    group_id = 5
    call = 'Word.count'
    assert_difference(call, 2, 'No change in word count') do
      create_word(base_entry, phonetic_entry, base_script, group_id)
    end
  end

  test 'create_sentence' do
    base_entry = 'would you'
    base_script = lang_by_name('English').base_script
    call = 'Sentence.count'
    assert_difference(call, 2, 'incorrect # of sents saved') do
      create_sentence(base_entry, base_script)
    end
  end

  test 'sentences_found_in' do
    word = word_by_id(10)
    sentence1 = sentence_by_id(2)
    sentence2 = sentence_by_id(8)
    template = [sentence1, sentence2]
    result = sentences_found_in(word)
    assert_equal(template, result, 'incorrect array returned')
  end

  test 'word_in_sentence?' do
    sentence = sentence_by_id(1)
    word = word_by_id(3)
    assert(word_in_sentence?(word, sentence), 'method returned wrong bool')
    word = word_by_id(4)
    assert(word_in_sentence?(word, sentence), 'method returned wrong bool')
    word = word_by_id(1)
    assert_not(word_in_sentence?(word, sentence), 'method returned wrong bool')
  end

  test 'language_stats' do
    language = lang_by_name('English')
    language_stats(language)
  end

  test 'content_add_helper' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    establish_chars(base_lang, target_lang)
    map_wts(base_lang, target_lang)

    target_script = lang_by_name('Spanish').base_script
    hurdle = 2
    base_script = lang_by_name('English').base_script

    content_add_helper(base_script, target_script, hurdle)
  end

  test 'next_word_below_hurdle' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')
    establish_chars(base_lang, target_lang)
    map_wts(base_lang, target_lang)

    target_script = lang_by_name('Spanish').base_script
    word_rep_counts = return_word_rep_counts(target_script)
    hurdle = 2
    base_script = lang_by_name('English').base_script
    template = word_by_id(16)
    result = next_word_below_hurdle(word_rep_counts, hurdle, base_script)
    assert_equal(template, result, 'Incorrect word returned')
  end
end

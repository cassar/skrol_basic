require 'test_helper'

class UtilitiesTest < ActiveSupport::TestCase
  test 'max_word_length should work as advertised' do
    script = lang_by_name('English').base_script

    assert_equal(7, max_word_length(script), 'max method not working')
  end

  test 'lang_by_name should work as advertised' do
    assert_not_nil(lang_by_name('English'), 'Failed to retrieve English.')
    assert_raises(Invalid, 'Did not raises Invalid') do
      lang_by_name('Jibberish')
    end
  end

  test 'translate_all_sentences should work as advertised' do
    base_lang = lang_by_name('English')
    target_lang = lang_by_name('Spanish')

    translate_all_sentences(base_lang, target_lang)

    base_count = base_lang.base_script.sentences.count
    target_count = target_lang.base_script.sentences.count

    assert_equal(base_count, target_count, 'Wrong # of sentences saved')
  end

  test 'derive_phonetics should work as advertised' do
    lang = lang_by_name('English')
    derive_phonetics(lang)
    base_count = lang.base_script.sentences.count
    phonetic_count = lang.phonetic_script.sentences.count
    assert_equal(base_count, phonetic_count, 'incorrect # of sentences saved')
  end

  test 'create_update_sentence should work as advertised' do
    base_script = lang_by_name('English').base_script
    phonetic_script = lang_by_name('English').phonetic_script

    count = 'Sentence.all.where(group_id: 5).count'
    assert_difference(count, 0, 'Wrong # of sentence objects saved') do
      create_update_sentence('whatever', base_script, 5)
    end

    assert_difference(count, 1, 'Sentence object should have saved') do
      create_update_sentence('whatever', phonetic_script, 5)
    end
  end
end

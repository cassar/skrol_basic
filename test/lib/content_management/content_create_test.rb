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
    assert_difference(call, 0, 'incorrect # of sents saved') do
      assert_raises(Invalid, 'Invalid not raised') do
        create_sentence('test this', base_script)
      end
    end
  end

  test 'missing_words_filler' do
    script = lang_by_name('English').base_script
    assert_difference('Word.count', 10, 'incorrect # of words saved') do
      missing_words_filler(script)
    end
    assert_equal(5, Word.where(entry: '[new]').count, 'incorrect news saved')
  end

  test 'remove_duplicates' do
  end

  test 'thread_fill_ipa' do
  end

  test 'fill_in_ipa_entries' do
  end

  # test 'derive_phonetics' do
  #   lang = lang_by_name('English')
  #   lang.phonetic_script.sentences.destroy_all
  #   derive_phonetics(lang)
  #   base_count = lang.base_script.sentences.count
  #   phonetic_count = lang.phonetic_script.sentences.count
  #   assert_equal(base_count, phonetic_count, 'incorrect # of sentences saved')
  # end

  test 'create_update_sentence' do
    base_script = lang_by_name('English').base_script
    phonetic_script = lang_by_name('English').phonetic_script

    count = 'Sentence.all.where(group_id: 5).count'
    assert_difference(count, 0, 'Wrong # of sentence objects saved') do
      create_update_sentence('whatever', base_script, 5)
    end

    count = 'Sentence.all.where(group_id: 8).count'
    assert_difference(count, 1, 'Sentence object should have saved') do
      create_update_sentence('whatever', phonetic_script, 8)
    end
  end

  test 'fill_in_phonetics' do
  end

  test 'fill_single_phonetic' do
  end

  # test 'translate_all_sentences' do
  #   base_lang = lang_by_name('English')
  #   target_lang = lang_by_name('Spanish')
  #
  #   translate_all_sentences(base_lang, target_lang)
  #
  #   base_count = base_lang.base_script.sentences.count
  #   target_count = target_lang.base_script.sentences.count
  #
  #   assert_equal(base_count, target_count, 'Wrong # of sentences saved')
  # end
end

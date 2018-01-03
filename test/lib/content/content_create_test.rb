require 'test_helper'

class CreateContentTest < ActiveSupport::TestCase
  test 'create_word' do
    standard_entry = 'tower'
    phonetic_entry = 'ˈtaʊ.ɚ'
    standard_script = lang_by_name('English').standard_script
    group_id = 5
    call = 'Word.count'
    assert_difference(call, 2, 'No change in word count') do
      create_word(standard_entry, phonetic_entry, standard_script, group_id)
    end
  end

  test 'derive_phonetics' do
    lang = lang_by_name('English')
    lang.phonetic_script.sentences.destroy_all
    derive_phonetics(lang)
    standard_count = lang.standard_script.sentences.count
    phonetic_count = lang.phonetic_script.sentences.count
    assert_equal(standard_count, phonetic_count, 'incorrect # of sentences saved')
  end

  test 'create_update_sentence' do
    standard_script = lang_by_name('English').standard_script
    phonetic_script = lang_by_name('English').phonetic_script

    count = 'Sentence.all.where(group_id: 5).count'
    assert_difference(count, 0, 'Wrong # of sentence objects saved') do
      create_update_sentence('whatever', standard_script, 5)
    end

    count = 'Sentence.all.where(group_id: 8).count'
    assert_difference(count, 1, 'Sentence object should have saved') do
      create_update_sentence('whatever', phonetic_script, 8)
    end
  end
end

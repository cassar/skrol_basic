require 'test_helper'

class UtilitiesTest < ActiveSupport::TestCase
  test 'max_word_length' do
    script = lang_by_name('English').base_script

    assert_equal(7, max_word_length(script), 'max method not working')
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

  test 'derive_phonetics' do
    lang = lang_by_name('English')
    lang.phonetic_script.sentences.each(&:destroy)
    derive_phonetics(lang)
    base_count = lang.base_script.sentences.count
    phonetic_count = lang.phonetic_script.sentences.count
    assert_equal(base_count, phonetic_count, 'incorrect # of sentences saved')
  end

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

  test 'return_word' do
    script = lang_by_name('English').base_script
    word = script.words.where(entry: 'bottle').first
    word2 = script.words.where(entry: 'Sydney').first

    assert_equal(word, return_word(script, 'bottle'), 'Did not find bottle')
    assert_equal(word2, return_word(script, 'sydney'), 'Did not find Sydney')
    assert_nil(return_word(script, 'soft'), 'error with none words')
  end
end

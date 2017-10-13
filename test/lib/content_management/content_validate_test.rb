require 'test_helper'

class ContentValidateTest < ActiveSupport::TestCase
  setup do
    @spanish = lang_by_name('Spanish')
    @base_script = @spanish.base_script
    @phonetic_script = @spanish.phonetic_script
  end

  test 'filter_words' do
    standard = @base_script.words
    phonetic = @phonetic_script.words
    new_stds, new_phons = filter_words(standard, phonetic)
    assert_not_nil(new_stds)
    assert_not_nil(new_phons)
    assert_equal(new_stds.count, new_phons.count)
  end

  test 'filter_sents' do
    standard = @base_script.sentences
    phonetic = @phonetic_script.sentences
    new_stds, new_phons = filter_sents(standard, phonetic)
    assert_not_nil(new_stds)
    assert_not_nil(new_phons)
    assert_equal(new_stds.count, new_phons.count)
  end

  test 'filter_groups' do
    english = lang_by_name('English')
    base_sents = english.base_script.sentences
    target_sents = @base_script.sentences
    new_targets, new_bases = filter_groups(target_sents, base_sents)
    assert_not_nil(new_targets)
    assert_not_nil(new_bases)
    assert_equal(new_bases.count, new_targets.count)
  end

  test 'remove_no_reps' do
    words = @base_script.words
    rep_sents = derive_rep_sents(words, @base_script.sentences)
    new_words = remove_no_reps(words, rep_sents)
    assert_not_nil(new_words)
  end

  test 'valid_ipa_entry_count' do
    sent_count, word_count = valid_ipa_entry_count(@spanish)
    assert_not_equal(0, sent_count)
    assert_not_equal(0, word_count)
  end
end

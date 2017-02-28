require 'test_helper'

class WordsCatalogueTest < ActiveSupport::TestCase
  test 'derive_words_catalogue' do
    script = lang_by_name('English').base_script
    script.sentences.destroy_all
    sentence =
      script.sentences.create(entry: 'Would you like a apple a pear?')

    template = { 'would' => 1, 'you' => 1, 'like' => 1,
                 'a' => 2, 'apple' => 1, 'pear' => 1 }

    assert_equal(template, derive_words_catalogue(script), 'objects not equal')
  end

  test 'add_words_to_catalogue' do
    script = lang_by_name('English').base_script
    sentence =
      script.sentences.where(entry: 'Would you like a apple a pear?').first

    catalogue = { 'apple' => 2, 'pear' => 1 }
    add_words_to_catalogue(sentence, catalogue)
    assert_equal(1, catalogue['would'], 'would should have 1 count')
    assert_equal(3, catalogue['apple'], 'apple should have 2 count')
  end

  test 'derive_word_entry_catalogue' do
  end

  test 'check_no_dup_entries' do
  end

  test 'analyse_count_catalogue' do
  end
end

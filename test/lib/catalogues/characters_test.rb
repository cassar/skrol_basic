require 'test_helper'

class CharactersCatalogueTest < ActiveSupport::TestCase
  test 'derive_chars_catalogue' do
    script = lang_by_name('English').base_script

    template = { 'h' => 3, 'e' => 9, 'l' => 7, 'o' => 6, 'c' => 3, 'w' => 2,
                 'u' => 4, 'd' => 2, 'y' => 3, 'a' => 4, 'p' => 5, 'r' => 4,
                 'b' => 3, 't' => 5, 'n' => 3, 'i' => 2, 's' => 2, 'm' => 1 }
    assert_equal(template, derive_chars_catalogue(script), 'objects not equal')
  end

  test 'add_chars_to_catalogue' do
    script = lang_by_name('English').base_script
    word = script.word_by_entry('apple')

    catalogue = { a: 0, p: 0, l: 0, e: 0 }
    add_chars_to_catalogue(word, catalogue)
    assert_equal(1, catalogue['a'], 'a should have 1 count')
    assert_equal(2, catalogue['p'], 'p should have 2 count')
  end
end

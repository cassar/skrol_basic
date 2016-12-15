require 'test_helper'

class UtilitiesTest < ActiveSupport::TestCase
  test 'max_word_length should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.where(entry: 'bottle').first

    assert_equal(7, max_word_length(script), 'max method not working')
  end

  test 'derive_chars_catalogue should work as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    script.words.each(&:destroy)
    script.words.create(entry: 'apple')

    template = { 'a' => 1, 'p' => 2, 'l' => 1, 'e' => 1 }
    assert_equal(template, derive_chars_catalogue(script), 'objects not equal')
  end

  test 'add_chars_to_catalogue should do what it says' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    word = script.words.create(entry: 'apple')

    catalogue = { a: 0, p: 0, l: 0, e: 0 }
    add_chars_to_catalogue(word, catalogue)
    assert_equal(1, catalogue['a'], 'a should have 1 count')
    assert_equal(2, catalogue['p'], 'p should have 2 count')
  end
end

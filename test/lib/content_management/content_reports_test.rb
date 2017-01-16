require 'test_helper'

class ContentReportsTest < ActiveSupport::TestCase
  test 'language_stats' do
    language = lang_by_name('English')
    language_stats(language)
  end

  test 'missing_words_filler' do
    script = lang_by_name('English').base_script
    assert_difference('Word.count', 10, 'incorrect # of words saved') do
      missing_words_filler(script)
    end
    assert_equal(5, Word.where(entry: '[new]').count, 'incorrect news saved')
  end

  test 'word_present?' do
    entry = 'hello'
    script = lang_by_name('English').base_script
    assert(word_present?(entry, script), 'should have returned true')
    entry = 'Hello'
    assert(word_present?(entry, script), 'should have returned true')
    entry = 'test'
    assert_not(word_present?(entry, script), 'should have returned false')
  end
end

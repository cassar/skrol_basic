require 'test_helper'

class StandardWordCheckerTest < ActiveSupport::TestCase
  test 'add and check words' do
    english_std = Script.find(1)
    spanish_std = Script.find(5)
    bulk_word_checker = BulkStandardWordCheck.new(english_std, spanish_std)
    hello = Word.find(1)
    assert_equal(hello, bulk_word_checker.process_entry('hello'))
  end
end

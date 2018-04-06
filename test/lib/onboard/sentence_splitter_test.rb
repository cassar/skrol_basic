require 'test_helper'

class SentenceSplitterTest < ActiveSupport::TestCase
  test 'string_extension' do
    assert('eeuueouo.'.contains_deliniator?)
    assert_not('eeuueouo'.contains_deliniator?)
    result = 'Hello how-are you?'.split_sentence
    template = %w[Hello how are you]
    assert_equal(template, result)
  end
end

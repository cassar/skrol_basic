require 'test_helper'

class ContentCleanupTest < ActiveSupport::TestCase
  test 'cleanup_sentences!' do
    script = lang_by_name('English').base_script
    call = 'Sentence.count'
    assert_difference(call, -4, 'incorrect # of sents removed') do
      cleanup_sentences!(script)
    end
  end
end

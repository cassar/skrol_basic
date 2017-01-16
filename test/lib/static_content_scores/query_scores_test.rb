require 'test_helper'

class QueryScoresTest < ActiveSupport::TestCase
  test 'retrieve_wts' do
    word_id = 26
    base_script = lang_by_name('English').base_script
    template = Score.first
    result = retrieve_wts(word_id, base_script)
    assert_equal(template, result, 'incorrect score retrieved')
    assert_raises(Invalid, 'Invalid not raised') do
      word_id = 1
      retrieve_wts(word_id, base_script)
    end
  end
end

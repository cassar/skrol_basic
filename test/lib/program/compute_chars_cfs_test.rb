require 'test_helper'

class CompileCharsCFSTest < ActiveSupport::TestCase
  test 'compile_chars_cfs' do
    script = lang_by_name('English')
    assert_not_empty(compile_chars_cfs(script), 'Should be something here.')
  end
end

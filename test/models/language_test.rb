require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test 'info' do
    Language.take.info
  end

  test 'all_info' do
    Language.all_info
  end
end

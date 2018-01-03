require 'test_helper'

class LanguageTest < ActiveSupport::TestCase
  test 'info' do
    Language.take.info
  end
end

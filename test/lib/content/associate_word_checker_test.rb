require 'test_helper'

class AssociateWordCheckerTest < ActiveSupport::TestCase
  setup do
    @standard_script = Script.find(1)
    @associate_script = Script.find(5)
    @std_words = @standard_script.words
  end

  test 'initialize' do
    AssociateWordChecker.new(@standard_script, @associate_script, BING)
  end
end

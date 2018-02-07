require 'test_helper'

class SuitableAssociateCompilerTest < ActiveSupport::TestCase
  setup do
    @lang_map = LanguageMap.find(1)
  end

  test 'compile' do
    SuitableAssociateCompiler.new(@lang_map).compile
    result = SentenceAssociate.take.representations
    template = [[1, 2, 3], [1, 2, 3]]
    assert_equal(template, result)
  end
end

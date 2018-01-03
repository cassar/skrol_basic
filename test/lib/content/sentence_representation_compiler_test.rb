require 'test_helper'

class SentenceRepresentationCompilerTest < ActiveSupport::TestCase
  setup do
    @sent_rep_compiler_english = SentenceRepresentationCompiler.new(Script.find(1))
    @sent_rep_compiler_spanish = SentenceRepresentationCompiler.new(Script.find(5))
  end

  test 'compile' do
    temp = [Word.find(1), Word.find(2), Word.find(3)]
    assert_equal(temp, @sent_rep_compiler_english.compile(Sentence.find(1)))
    temp = [Word.find(7), Word.find(8), Word.find(9)]
    assert_equal(temp, @sent_rep_compiler_spanish.compile(Sentence.find(2)))
  end
end

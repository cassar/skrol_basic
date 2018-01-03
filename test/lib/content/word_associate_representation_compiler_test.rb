require 'test_helper'

class WordAssociateRepresentationCompilerTest < ActiveSupport::TestCase
  setup do
    spanish = Script.find(5)
    english = Script.find(1)
    @word_assoc_rep_compiler = WordAssociateRepresentationCompiler.new([spanish, english])
  end

  test 'compile' do
    sent_assoc_rep1, sent_assoc_rep2 = @word_assoc_rep_compiler.compile(SentenceAssociate.find(1))
    template1 = [WordAssociate.find(1), WordAssociate.find(2), WordAssociate.find(3)]
    assert_equal(template1, sent_assoc_rep1)
    assert_equal(template1, sent_assoc_rep2)
  end

  test 'suitable_sentence_associates' do
    assoc = SentenceAssociate.find(1)
    words = [Word.find(1), Word.find(2), Word.find(3), Word.find(7), Word.find(8), Word.find(9)]
    template = [[assoc], [WordAssociate.find(1), WordAssociate.find(2), WordAssociate.find(3)]]
    assert_equal(template, @word_assoc_rep_compiler.suitable_sentence_associates(words))
  end
end

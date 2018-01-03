require 'test_helper'

class WordAssociateManagerTest < ActiveSupport::TestCase
  setup do
    spanish = Script.find(5)
    english = Script.find(1)
    @word_assoc_manager = WordAssociateManager.new([spanish, english])
  end

  test 'associates' do
    assocs = @word_assoc_manager.associates(Word.find(9))
    template = [WordAssociate.find(3)]
    assert_equal(template, assocs)
  end

  test 'corresponding' do
    hello = Word.find(1)
    hola = Word.find(7)
    word_assoc = WordAssociate.find(1)
    assert_equal(hola, @word_assoc_manager.corresponding(hello, word_assoc))
    assert_equal(hello, @word_assoc_manager.corresponding(hola, word_assoc))
  end

  test 'words' do
    thanks = Word.find(2)
    gracias = Word.find(8)
    word_assoc = WordAssociate.find(2)
    assert_equal([gracias, thanks], @word_assoc_manager.words(word_assoc))
  end
end

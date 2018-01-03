require 'test_helper'

class SentencesWordTest < ActiveSupport::TestCase
  setup do
    @sentence1 = Sentence.find(1)
    @sentence2 = Sentence.find(2)
  end

  test 'words' do
    temp = [Word.find(1), Word.find(2), Word.find(3)]
    assert_equal(temp, @sentence1.words)
    temp = [Word.find(7), Word.find(8), Word.find(9)]
    assert_equal(temp, @sentence2.words)
  end
end

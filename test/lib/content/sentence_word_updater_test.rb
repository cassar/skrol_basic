require 'test_helper'

class SentenceWordUpdaterTest < ActiveSupport::TestCase
  setup do
    @sentence = Sentence.find(1)
    @sentence.words.clear
    script = Script.find(1)
    script.words.create(entry: 'hello tha')
    @sent_word_updater = SentenceWordUpdater.new(script)
  end

  test 'update' do
    temp = [Word.find(1), Word.find(2), Word.find(3)]
    result = @sent_word_updater.update(@sentence)
    assert_equal(temp, result)
  end
end

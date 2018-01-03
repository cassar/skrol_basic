require 'test_helper'

class StandardWordCheckerTest < ActiveSupport::TestCase
  setup do
    @standard_script = Script.find(1)
    @associate_script = Script.find(5)
  end

  test 'check' do
    WordPhonetic.destroy_all
    WordAssociate.destroy_all
    checker = StandardWordChecker.new(@standard_script, @associate_script)
    word = Word.find(1)
    call = 'WordPhonetic.count + WordAssociate.count'
    assert_difference(call, 2) do
      checker.check(word)
    end
  end

  test 'sentence_word_linked' do
    WordPhonetic.destroy_all
    WordAssociate.destroy_all
    checker = StandardWordChecker.new(@standard_script, @associate_script)
    call = 'WordPhonetic.count + WordAssociate.count'
    assert_difference(call, 6) do
      checker.sentence_word_linked
    end
  end
end

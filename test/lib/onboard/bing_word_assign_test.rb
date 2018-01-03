require 'test_helper'

class BingWordAssignTest < ActiveSupport::TestCase
  setup do
    @english = Script.find(1)
    @spanish = Script.find(5)
    @associate_pair = [@english, @spanish]
    @assoc_check_word = SentinalManager.retrieve(NONE, @spanish)
  end

  test 'assign_assocs' do
    hello = Word.find(1)
    WordAssociate.find(1).update(associate_b: @assoc_check_word)
    Word.find(7).destroy
    BingWordAssign.create_metadatum(@english, 'en')
    BingWordAssign.create_metadatum(@spanish, 'es')
    BingWordAssign.assign_assocs(@associate_pair)
    assert_equal(Word.find_by(entry: 'hola'), hello.all_associates.first)
  end
end

require 'test_helper'

class BingWordAssignTest < ActiveSupport::TestCase
  setup do
    @english = Script.find(1)
    @spanish = Script.find(5)
    @associate_pair = [@english, @spanish]
  end

  test 'assign_assocs' do
    WordAssociate.destroy_all
    BingWordAssign.create_metadatum(@english, 'en')
    BingWordAssign.create_metadatum(@spanish, 'es')
    assert_difference('WordAssociate.count', 3) do
      BingWordAssign.assign_assocs(@associate_pair)
    end
  end
end

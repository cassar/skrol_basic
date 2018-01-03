require 'test_helper'

class WordAssociateTest < ActiveSupport::TestCase
  test 'relations' do
    wa = WordAssociate.take
    bottle = Word.find(7)
    bottiglia = Word.find(20)

    assert_equal(bottle, wa.associate_a, 'associate_a not working')
    assert_equal(bottiglia, wa.associate_b, 'associate_b not working')
  end
end

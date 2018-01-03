require 'test_helper'

class SentenceAssociateTest < ActiveSupport::TestCase
  test 'relations' do
    english_sent = Sentence.find(2)
    spanish_sent = Sentence.find(3)
    sa = SentenceAssociate.take

    assert_equal(english_sent, sa.associate_a, 'no associate a')
    assert_equal(spanish_sent, sa.associate_b, 'no associate b')
  end
end

require 'test_helper'

class RepSentTest < ActiveSupport::TestCase
  test 'RepSent validations' do
    call = 'RepSent.count'
    word = Word.first
    rep_sent = nil
    assert_difference(call, 2, 'incorrect repsents saved') do
      word.rep_sents.create
      rep_sent = word.rep_sents.create(rep_sent_id: 2)
      word.rep_sents.create(rep_sent_id: 2)
      word.rep_sents.create(rep_sent_id: 4, sentence_rank: 3)
      word.rep_sents.create(rep_sent_id: 5, sentence_rank: 3)
    end
    assert_equal(word, rep_sent.word, 'word record not returned!')
  end
end

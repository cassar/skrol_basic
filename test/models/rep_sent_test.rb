require 'test_helper'

class RepSentTest < ActiveSupport::TestCase
  test 'RepSent validations' do
    call = 'RepSent.count'
    word = Word.first
    rep_sent = nil
    assert_difference(call, 1, 'incorrect repsents saved') do
      word.rep_sents.create
      rep_sent = word.rep_sents.create(rep_sent_id: 2)
      word.rep_sents.create(rep_sent_id: 2)
    end
    assert_equal(word, rep_sent.word, 'word record not returned!')
  end

  test 'create_update_rank' do
    rep_sent = RepSent.first
    lang_map = LangMap.first
    entry = 2
    rep_sent.create_update_rank(lang_map, entry)
    assert_equal(2, Rank.first.entry, 'incorrect entry saved')
  end
end

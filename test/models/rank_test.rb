require 'test_helper'

class RankTest < ActiveSupport::TestCase
  test 'Rank validations' do
    word = Word.third
    call = 'Rank.count'
    rank = nil
    assert_difference(call, 2, 'incorrect # of ranks saved') do
      rank = word.ranks.create(entry: 1, lang_map_id: 1)
      word.ranks.create(entry: 1, lang_map_id: 1)
      word.ranks.create(entry: 1, lang_map_id: 2)
    end
    assert_equal(word, rank.entriable, 'incorrect word record returned')
    rep_sent = RepSent.first
    assert_difference(call, 2, 'incorrect # of ranks saved') do
      rank = rep_sent.ranks.create(entry: 1, lang_map_id: 3)
      rep_sent.ranks.create(entry: 1, lang_map_id: 3)
      rep_sent.ranks.create(entry: 1, lang_map_id: 2)
    end
    assert_equal(rep_sent, rank.entriable, 'incorrect word record returned')
  end
end

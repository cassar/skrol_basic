require 'test_helper'

class RankTest < ActiveSupport::TestCase
  test 'Rank validations' do
    word = Word.first
    call = 'Rank.count'
    rank = nil
    assert_difference(call, 2, 'incorrect # of ranks saved') do
      rank = word.ranks.create(rank_num: 1, lang_map_id: 1)
      word.ranks.create(rank_num: 1, lang_map_id: 1)
      word.ranks.create(rank_num: 1, lang_map_id: 2)
    end
    assert_equal(word, rank.word, 'incorrect word record returned')
  end
end

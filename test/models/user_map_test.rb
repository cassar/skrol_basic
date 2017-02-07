require 'test_helper'

class UserMapTest < ActiveSupport::TestCase
  test 'User to UserMap association and validations' do
    luke = user_by_name('Luke')
    lang_map = LangMap.first
    call = 'UserMap.count'
    assert_difference(call, 2, 'incorrect # of user maps saved') do
      luke.user_maps.create(lang_map_id: 2, word_rank: 1)
      luke.user_maps.create(lang_map_id: lang_map.id, word_rank: 1)
      luke.user_maps.create(lang_map_id: lang_map.id)
      luke.user_maps.create(lang_map_id: 3, word_rank: 1)
    end
    user_map = UserMap.first
    assert_equal(luke, user_map.user, 'User record did not return')
    assert_equal(lang_map, user_map.lang_map, 'Lang_map record did not return')
  end

  test 'UserMap associations' do
    user_map = UserMap.first
    call = 'user_map.user_scores.count'
    assert_difference(call, 1, 'score did not save') do
      user_map.user_scores.create(target_word_id: 15, entry: 0.09,
                                  status: 'tested')
    end
    call = 'user_map.user_metrics.count'
    assert_difference(call, 1, 'score did not save') do
      user_map.user_metrics.create(target_word_id: 14, target_sentence_id: 9,
                                   speed: 40, pause: false, hover: true,
                                   hide: false)
    end
  end

  test 'lang_map' do
  end

  test 'base_script' do
  end

  test 'target_script' do
  end

  test 'create_touch_score' do
  end

  test 'UserMap.create_touch_score' do
    user_map = UserMap.first
    target_word = Word.find(14)
    call = 'UserScore.count'
    assert_difference(call, 0, 'score did not update') do
      user_map.create_touch_score(target_word)
    end
    target_word = Word.find(15)
    assert_difference(call, 1, 'score did not update') do
      user_map.create_touch_score(target_word)
    end
  end

  test 'UserMap.create_metric_stub' do
    user_map = UserMap.first
    target_sentence = Sentence.find(3)
    target_word = Word.find(1)
    call = 'UserMetric.count'
    assert_difference(call, 1, 'metric failed to save') do
      user_map.create_metric_stub(target_word, target_sentence)
    end
  end

  test 'UserMap.raise_to_threshold' do
  end

  test 'retrieve_user_score' do
  end
end

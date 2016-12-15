require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  test 'Score.create should only save whole records' do
    script = lang_by_name('English').base_script
    word = script.word_by_entry('apple')
    score = word.scores.create(map_to_id: 2, map_to_type: 'words',
                               name: 'WFS', entry: 0.5)
    word.scores.create(map_to_id: 2, map_to_type: 'words',
                       name: 'WFS', entry: 0.5)
    word.scores.create(map_to_id: 2, map_to_type: 'words',
                       name: 'WLS', entry: 0.5)
    word.scores.create(map_to_id: 3, map_to_type: 'words',
                       name: 'WFS', entry: 0.5)
    word.scores.create(map_to_id: 2, map_to_type: 'words', name: 'WFS')

    assert_equal(3, Score.count, 'Incorrect # of scores created.')
    assert_not_nil(score.entriable, '.entriable method does not work.')
  end
end

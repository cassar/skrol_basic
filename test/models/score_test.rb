require 'test_helper'

class ScoreTest < ActiveSupport::TestCase
  test 'Score.create should only save whole records' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin script (English alphabet)')
    word = script.words.create(entry: 'apple')
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

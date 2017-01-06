require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  test 'Character.create and destroy' do
    script = lang_by_name('English').base_script
    call = 'script.characters.count'
    assert_difference(call, 2, 'wrong number of chars saved') do
      script.characters.create(entry: 'a')
      script.characters.create(entry: 'a')
      script.characters.create(entry: ' ')
    end
    script = lang_by_name('Spanish').base_script
    char = script.characters.create(entry: 'a')
    score = char.scores.create(map_to_id: 2, map_to_type: 'Character',
                               name: 'CFS', entry: 0.23)

    assert_not_nil(score, 'Score did not save.')
    score_count = Score.where(name: 'CFS').count
    assert_equal(1, score_count, 'No scores saved')

    assert_not_nil(char.script, '.script method does not work.')
    assert_not_nil(char.language, '.language method does not work.')

    char.destroy
    score_count = Score.where(name: 'CFS').count
    assert_equal(0, score_count, 'Score did not destroy.')
  end
end

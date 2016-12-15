require 'test_helper'

class CharacterTest < ActiveSupport::TestCase
  test 'Character.create and destroy should satisfy integrity constraints' do
    script = lang_by_name('English').base_script
    script.characters.create(entry: 'a')
    script.characters.create(entry: 'a')
    script.characters.create

    script = lang_by_name('Spanish').base_script
    char = script.characters.create(entry: 'a')
    score = char.scores.create(map_to_id: 2, map_to_type: 'characters',
                               name: 'CFS', entry: 0.23)

    assert_not_nil(score, 'Score did not save.')
    assert_equal(1, Score.count, 'No scores saved.')

    assert_equal(6, Character.count, 'Wrong number of characters saved!')
    assert_not_nil(char.script, '.script method does not work.')
    assert_not_nil(char.language, '.language method does not work.')

    char.destroy
    assert_equal(0, Score.count, 'Score did not destroy.')
  end
end

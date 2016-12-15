require 'test_helper'

class SentenceTest < ActiveSupport::TestCase
  test 'Sentence.create and destroy should satisfy integrity constraints' do
    script = lang_by_name('English').base_script
    sentence = script.sentences.create(entry: 'Apple on my head.')
    script.sentences.create(entry: 'Apple on my head.')
    script.sentences.create

    script = lang_by_name('Spanish').base_script
    sentence = script.sentences.create(entry: 'Apple on my head.')
    score = sentence.scores.create(map_to_id: 2, map_to_type: 'sentences',
                                   name: 'SWLS', entry: 0.23)

    assert_not_nil(score, 'Score did not save.')
    assert_equal(1, Score.count, 'No scores saved.')

    assert_equal(13, Sentence.count, 'Wrong number of sentences saved!')
    assert_not_nil(sentence.script, '.script method does not work.')
    assert_not_nil(sentence.language, '.language method does not work.')

    sentence.destroy
    assert_equal(0, Score.count, 'Score did not destroy.')
  end
end

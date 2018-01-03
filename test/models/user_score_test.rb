require 'test_helper'

class UserScoreTest < ActiveSupport::TestCase
  test 'user_score validations' do
    enrolment = Enrolment.first
    call = 'enrolment.user_scores.count'
    assert_difference(call, 1, 'wrong number of scores saved') do
      enrolment.user_scores.create
      enrolment.user_scores.create(target_word_id: 1, status: 'tested')
      enrolment.user_scores.create(target_word_id: 1, entry: 0.5, status: 'tested')
      enrolment.user_scores.create(target_word_id: 1, entry: 0.5, status: 'tested')
    end
    score = enrolment.user_scores.create(target_word_id: 1, entry: 0.5,
                                         status: 'tested')
    assert_equal(enrolment, score.enrolment, '.enrolment association does not work')
  end

  test 'UserScore.target_script' do
    user_score = UserScore.first

    template = lang_by_name('Spanish').standard_script
    result = user_score.target_script
    assert_equal(template, result, 'target_script did not work')
  end

  test 'UserScore.increment_sentence_rank' do
  end
end

require 'test_helper'

class UtilitiesTest < ActiveSupport::TestCase
  test 'max_word_length' do
    script = lang_by_name('English').base_script

    assert_equal(7, max_word_length(script), 'max method not working')
  end

  # test 'translate_all_sentences' do
  #   base_lang = lang_by_name('English')
  #   target_lang = lang_by_name('Spanish')
  #
  #   translate_all_sentences(base_lang, target_lang)
  #
  #   base_count = base_lang.base_script.sentences.count
  #   target_count = target_lang.base_script.sentences.count
  #
  #   assert_equal(base_count, target_count, 'Wrong # of sentences saved')
  # end

  test 'return_user_word_score' do
    metric = UserMetric.second
    score = UserScore.first
    template = 0.49999999999999994
    result = return_user_word_score(metric, score)
    assert_equal(template, result, 'incorrect score returned')
  end

  test 'fix_new_entry' do
    result = fix_new_entry(0.5)
    assert_equal(0.5, result, 'incorrect value returned')
    result = fix_new_entry(-1)
    assert_equal(0.0, result, 'incorrect value returned')
    result = fix_new_entry(2.0)
    assert_equal(1.0, result, 'incorrect value returned')
  end

  test 'return_speed_adjustment' do
    template = 0.6666666666666667
    result = return_speed_adjustment(20)
    assert_equal(template, result, 'incorrect score returned')
  end
end

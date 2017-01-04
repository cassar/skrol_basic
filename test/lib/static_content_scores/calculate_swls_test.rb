require 'test_helper'

class CalculateSWLSTest < ActiveSupport::TestCase
  test 'calculate_swls' do
    script = lang_by_name('English').base_script
    sentence = script.sentences.create(entry: 'I would like it.')

    result = calculate_swls(sentence)
    assert_equal(3.0 / 7, result, 'Wrong swls score returned')
  end

  test 'max_sentence_word_length' do
    script = lang_by_name('English').base_script
    sentence = script.sentences.create(entry: 'I would like it.')

    result = max_sentence_word_length(script)
    assert_equal(7, result, 'incorrect length returned')
  end
end

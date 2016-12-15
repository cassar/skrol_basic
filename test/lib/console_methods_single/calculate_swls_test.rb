require 'test_helper'

class CalculateSWLSTest < ActiveSupport::TestCase
  test 'calculate_swls works as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    sentence = script.sentences.create(entry: 'I would like it.')

    result = calculate_swls(sentence)
    assert_equal(3.0 / 7, result, 'Wrong swls score returned')
  end

  test 'max_sentence_word_length works as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.where(name: 'Latin').first
    sentence = script.sentences.create(entry: 'I would like it.')

    result = max_sentence_word_length(script)
    assert_equal(7, result, 'incorrect length returned')
  end
end

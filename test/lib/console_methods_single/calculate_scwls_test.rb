require 'test_helper'

class CalculateSCWLSTest < ActiveSupport::TestCase
  test 'calculate_scwls works as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    sentence = script.sentences.create(entry: 'I would like it.')
    script.words.create(entry: 'I')
    script.words.create(entry: 'would')
    script.words.create(entry: 'like')
    script.words.create(entry: 'it')
    compile_wls_script(script)

    result = calculate_scwls(sentence)
    assert_equal(0.4, result, 'incorrect scwls returned')
  end

  test 'retrieve_wls_score works as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    sentence = script.sentences.create(entry: 'I would like it.')
    script.words.create(entry: 'I')
    script.words.create(entry: 'would')
    script.words.create(entry: 'like')
    script.words.create(entry: 'it')
    compile_wls_script(script)

    result = retrieve_wls_score('like', script)
    assert_equal(1.0 / 5, result, 'incorrect wls retrieved')
  end
end

require 'test_helper'

class CalculateSWFSTest < ActiveSupport::TestCase
  test 'calculate_swfs works as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    sentence = script.sentences.create(entry: 'I would like it.')
    script.words.create(entry: 'I')
    script.words.create(entry: 'would')
    script.words.create(entry: 'like')
    script.words.create(entry: 'it')
    compile_wfs_script(script)

    result = calculate_swfs(sentence)
    assert_equal(1.0 / 4, result, 'incorrect swfs returned')
  end

  test 'retrieve_wfs_score works as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    sentence = script.sentences.create(entry: 'I would like it.')
    script.words.create(entry: 'I')
    script.words.create(entry: 'would')
    script.words.create(entry: 'like')
    script.words.create(entry: 'it')
    compile_wfs_script(script)

    result = retrieve_wfs_score('like', script)
    assert_equal(1.0 / 4, result, 'incorrect wfs retrieved')
  end
end

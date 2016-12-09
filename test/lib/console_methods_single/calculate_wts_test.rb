require 'test_helper'

class CalculateWTSTest < ActiveSupport::TestCase
  test 'compile_wts should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle', group_id: 1)
    script.words.create(entry: 'crumble', group_id: 2)
    script.sentences.create(entry: 'bottle and crumble!')
    script.sentences.create(entry: 'crumble the bottle?')
    compile_chars_cfs(script)

    lang2 = Language.create(name: 'Italian')
    script2 = lang2.scripts.create(name: 'Latin')
    word2 = script2.words.create(entry: 'bottiglia', group_id: 1)
    script2.words.create(entry: 'crollare', group_id: 2)
    script2.sentences.create(entry: 'bottiglia e si sbriciolano!')
    script2.sentences.create(entry: 'sbriciolare la bottiglia?')
    compile_chars_cfs(script2)

    compile_wts(word2, script)
    score = word2.scores.where(name: 'WTS').first
    assert_not_nil(score, 'score did not save!')
    assert_equal(0.355433455433455, score.entry, 'incorrect score saved!')
  end

  test 'calculate_wts should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle', group_id: 1)
    script.words.create(entry: 'crumble', group_id: 2)
    script.sentences.create(entry: 'bottle and crumble!')
    script.sentences.create(entry: 'crumble the bottle?')
    compile_chars_cfs(script)

    lang2 = Language.create(name: 'Italian')
    script2 = lang2.scripts.create(name: 'Latin')
    word2 = script2.words.create(entry: 'bottiglia', group_id: 1)
    script2.words.create(entry: 'crollare', group_id: 2)
    script2.sentences.create(entry: 'bottiglia e si sbriciolano!')
    script2.sentences.create(entry: 'sbriciolare la bottiglia?')
    compile_chars_cfs(script2)

    score = calculate_wts(word2, script)
    template = 0.3554334554334554
    assert_equal(template, score, 'Incorrect WTS score saved')
  end

  test 'return_word_scores should work as advertised' do
    lang = Language.create(name: 'English')
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle', group_id: 1)
    script.words.create(entry: 'crumble', group_id: 2)
    script.sentences.create(entry: 'bottle and crumble!')
    script.sentences.create(entry: 'crumble the bottle?')
    compile_chars_cfs(script)

    lang2 = Language.create(name: 'Italian')
    script2 = lang2.scripts.create(name: 'Latin')
    word2 = script2.words.create(entry: 'bottiglia', group_id: 1)
    script2.words.create(entry: 'crollare', group_id: 2)
    script2.sentences.create(entry: 'bottiglia e si sbriciolano!')
    script2.sentences.create(entry: 'sbriciolare la bottiglia?')
    compile_chars_cfs(script2)

    template = [0.07692307692307698, 0.11111111111111081, 0.2857142857142857,
                0.0, 0.5777777777777777]
    result = return_word_scores(word2, script)
    assert_equal(template, result, 'Incorrect score array calculated')
  end
end

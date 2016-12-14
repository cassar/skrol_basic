require 'test_helper'

class CalculateSCWTSTest < ActiveSupport::TestCase
  test 'calculate_scwts works as advertised' do
    lang = Language.where(name: 'English').first
    base_script = lang.scripts.create(name: 'Latin')
    sentence = base_script.sentences.create(entry: 'The car is blue!')
    word = base_script.words.create(entry: 'The', group_id: 1)
    word2 = base_script.words.create(entry: 'car', group_id: 2)
    word3 = base_script.words.create(entry: 'is', group_id: 3)
    word4 = base_script.words.create(entry: 'blue', group_id: 4)
    compile_chars_cfs(base_script)

    lang = Language.create(name: 'Spanish')
    script = lang.scripts.create(name: 'Latin')
    target_sentence =
      script.sentences.create(entry: 'El coche es de color azul!')
    word5 = script.words.create(entry: 'el', group_id: 1)
    word6 = script.words.create(entry: 'coche', group_id: 2)
    word7 = script.words.create(entry: 'es', group_id: 3)
    word8 = script.words.create(entry: 'de')
    word9 = script.words.create(entry: 'color')
    word10 = script.words.create(entry: 'azul', group_id: 4)
    compile_chars_cfs(script)

    result = calculate_scwts(target_sentence, base_script)
    template = 0.21915972222222221
    assert_equal(template, result, 'incorrect scwts returned')
  end

  test 'retrieve_wts_score works as advertised' do
    lang = Language.where(name: 'English').first
    script = lang.scripts.create(name: 'Latin')
    word = script.words.create(entry: 'bottle', group_id: 1)
    script.words.create(entry: 'crumble', group_id: 2)
    script.sentences.create(entry: 'bottle and crumble!')
    script.sentences.create(entry: 'crumble the bottle?')
    compile_chars_cfs(script)

    lang2 = Language.where(name: 'Italian').first
    script2 = lang2.scripts.create(name: 'Latin')
    word2 = script2.words.create(entry: 'bottiglia', group_id: 1)
    script2.words.create(entry: 'crollare', group_id: 2)
    script2.sentences.create(entry: 'bottiglia e si sbriciolano!')
    script2.sentences.create(entry: 'sbriciolare la bottiglia?')
    compile_chars_cfs(script2)

    result = retrieve_wts_score('crollare', script2, script)
    template = 0.26624560080442433
    assert_equal(template, result, 'incorrect wts score returned')
  end
end

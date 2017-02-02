require 'test_helper'

class SentenceTest < ActiveSupport::TestCase
  test 'Sentence integrity constraints' do
    base_script = lang_by_name('English').base_script
    target_script = lang_by_name('Spanish').base_script

    call = 'Sentence.count'
    assert_difference(call, 2, 'Wrong number of sentences saved!') do
      base_script.sentences.create(entry: 'Apple on my head.')
      # base_script.sentences.create(entry: 'Apple on my head.')
      base_script.sentences.create
      target_script.sentences.create(entry: 'Apple on my head.')
    end

    sentence = base_script.sentences.create(entry: 'Test Sentence.')
    assert_not_nil(sentence.script, '.script method does not work.')
    assert_not_nil(sentence.language, '.language method does not work.')

    call = "Score.where(name: 'SWLS').count"
    assert_difference(call, 1, 'score did not save') do
      sentence.scores.create(map_to_id: 2, map_to_type: 'Sentence',
                             name: 'SWLS', entry: 0.23)
    end
  end

  test 'Sentence.create_phonetic' do
    base_sentence = sentence_by_id(2)
    call = 'Sentence.count'
    assert_difference(call, 1, 'sentence did not save') do
      base_sentence.create_phonetic
    end
  end

  test 'Sentence.retrieve_score' do
    puts Score.where(name: 'STS', entriable_id: 3).count
    sentence = sentence_by_id(3)
    base_script = lang_by_name('English').base_script
    score = Score.where(entriable_id: 3).first
    lang_map = LangMap.first

    retrieved = sentence.retrieve_score('STS', lang_map)
    assert_equal(score, retrieved, 'retrieve_sts did not work')
    sentence = Sentence.first
    assert_raises(Invalid, 'Invalid failed to raise') do
      sentence.retrieve_score('STS', lang_map)
    end
  end

  test 'Sentence.phonetic' do
    sentence = sentence_by_id(5)
    template = sentence_by_id(12)
    assert_equal(template, sentence.phonetic, '.phonetic did not work')
  end

  test 'Sentence.create_update_score' do
    lang_map = LangMap.first

    call = "Score.where(name: 'STS', entriable_id: 3).count"
    target_sentence = sentence_by_id(3)
    assert_difference(call, 0, 'incorrect scores saved') do
      target_sentence.create_update_score('STS', lang_map, 0.09)
    end

    call = "Score.where(name: 'STS', entriable_id: 9).count"
    target_sentence = sentence_by_id(9)
    Score.destroy_all
    assert_difference(call, 1, 'incorrect scores saved') do
      target_sentence.create_update_score('STS', lang_map, 0.54)
    end
  end

  test 'Sentence.corresponding' do
  end
end

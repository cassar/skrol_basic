require 'test_helper'

class SentenceTest < ActiveSupport::TestCase
  test 'Sentence integrity constraints' do
    base_script = lang_by_name('English').base_script
    target_script = lang_by_name('Spanish').base_script

    call = 'Sentence.count'
    assert_difference(call, 2, 'Wrong number of sentences saved!') do
      base_script.sentences.create(entry: 'Apple on my head.')
      base_script.sentences.create(entry: 'Apple on my head.')
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

  test 'create_phonetic' do
    base_sentence = sentence_by_id(2)
    call = 'Sentence.count'
    assert_difference(call, 1, 'sentence did not save') do
      base_sentence.create_phonetic
    end
  end

  test 'retrieve_sts' do
    sentence = sentence_by_id(3)
    base_script = lang_by_name('English').base_script
    score = Score.where(entriable_id: 3).first

    retrieved = sentence.retrieve_sts(base_script)
    assert_equal(score, retrieved, 'retrieve_sts did not work')
    sentence = Sentence.first
    assert_raises(Invalid, 'Invalid failed to raise') do
      sentence. retrieve_sts(base_script)
    end
  end

  test '.phonetic' do
    sentence = sentence_by_id(5)
    template = sentence_by_id(12)
    assert_equal(template, sentence.phonetic, '.phonetic did not work')
  end

  test 'create_update_sts' do
    target_sentence = sentence_by_id(3)
    base_script = lang_by_name('English').base_script
    call = "Score.where(name: 'STS').count"
    assert_difference(call, 0, 'incorrect scores saved') do
      target_sentence.create_update_sts(0.09, base_script)
    end
    target_sentence = sentence_by_id(9)
    assert_difference(call, 1, 'incorrect scores saved') do
      target_sentence.create_update_sts(0.54, base_script)
    end
  end

  test 'Word.retrieve_svs' do
  end
end

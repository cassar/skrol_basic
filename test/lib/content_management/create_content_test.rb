require 'test_helper'

class CreateContentTest < ActiveSupport::TestCase
  test 'create_word' do
    base_entry = 'tower'
    phonetic_entry = 'ˈtaʊ.ɚ'
    base_script = lang_by_name('English').base_script
    group_id = 5
    call = 'Word.count'
    assert_difference(call, 2, 'No change in word count') do
      create_word(base_entry, phonetic_entry, base_script, group_id)
    end
  end

  test 'create_sentence' do
    base_entry = 'would you'
    base_script = lang_by_name('English').base_script
    call = 'Sentence.count'
    assert_difference(call, 2, 'incorrect # of sents saved') do
      create_sentence(base_entry, base_script)
    end
    assert_difference(call, 0, 'incorrect # of sents saved') do
      assert_raises(Invalid, 'Invalid not raised') do
        create_sentence('test this', base_script)
      end
    end
  end

  test 'create_slide' do
    base_entry = 'the car'
    base_script = lang_by_name('English').base_script
    target_script = lang_by_name('Spanish').base_script
    call = 'Sentence.count'
    assert_difference(call, 4, 'incorrect # of sents saved') do
      create_slide(base_entry, base_script, target_script)
    end
  end
end

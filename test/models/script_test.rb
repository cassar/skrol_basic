require 'test_helper'

class ScriptTest < ActiveSupport::TestCase
  setup do
    @romanian = Language.create(name: 'Romanian')
    @english = Script.first
  end

  test 'Script.create' do
    assert_difference('Script.count', difference = 1) do
      @romanian.scripts.create
      @romanian.scripts.create(name: 'Latin')
      @romanian.scripts.create(name: 'Latin')
    end
  end

  test 'Script .standard and .phonetic' do
    standard = Script.find(1)
    phonetic = Script.find(2)
    assert_equal(standard, phonetic.standard)
    assert_equal(phonetic, standard.phonetic)
    assert_nil(phonetic.phonetic)
    assert_nil(standard.standard)
  end

  test 'words_with_phonetics' do
    @english.words.create(entry: 'test')
    result = @english.words_with_phonetics
    template = [Word.first, Word.second, Word.third]
    assert_equal(template, result)
  end
end

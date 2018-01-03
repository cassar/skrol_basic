require 'test_helper'

class DbnaryLoaderTest < ActiveSupport::TestCase
  test 'DbnaryLoader._fr_test' do
    phonetic_script = Script.find(10)
    DbnaryLoader.assign_meta_datum(phonetic_script, 'fr', ['@fr-fonipa'])
    assert_difference('phonetic_script.language.words.count', 7, 'words did not save!') do
      DbnaryLoader.load(phonetic_script)
      phonetic_script.standard.words.each { |w| puts w.entry }
    end
  end

  test 'DbnaryLoader._it_test' do
    phonetic_script = Script.find(4)
    DbnaryLoader.assign_meta_datum(phonetic_script, 'it', ['@it-fonipa'])
    assert_difference('phonetic_script.language.words.count', 7, 'words did not save!') do
      DbnaryLoader.load(phonetic_script)
    end
  end

  test 'DbnaryLoader._en_test' do
    phonetic_script = Script.find(2)
    DbnaryLoader.assign_meta_datum(phonetic_script, 'en', ['@en-fonipa'])
    assert_difference('phonetic_script.language.words.count', 7, 'words did not save!') do
      DbnaryLoader.load(phonetic_script)
    end
  end

  test 'DbnaryLoader._es_test' do
    phonetic_script = Script.find(6)
    DbnaryLoader.assign_meta_datum(phonetic_script, 'es', ['@es-ipa', '@es-y-ipa', '@es-ll-ipa', '@es-c-ipa', '@es-s-ipa'])
    assert_difference('phonetic_script.language.words.count', 13, 'words did not save!') do
      DbnaryLoader.load(phonetic_script)
    end
  end
end

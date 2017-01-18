require 'test_helper'

class RetrieveIPATest < ActiveSupport::TestCase
  test 'retrieve_ipa_from_wiktionary' do
    base_script = lang_by_name('Spanish').base_script

    word = base_script.words.create(entry: 'perro')
    template = 'ˈpe.ro'
    result = retrieve_ipa_from_wiktionary(word.entry, base_script)
    assert_equal(template, result, 'incorrect ipa returned')

    word = base_script.words.create(entry: 'algún')
    result = retrieve_ipa_from_wiktionary(word.entry, base_script)
    assert_nil(result, 'should have returned nil')

    word = base_script.words.create(entry: 'intención')
    template = 'in.ten.ˈθjon'
    result = retrieve_ipa_from_wiktionary(word.entry, base_script)
    assert_equal(template, result, 'incorrect ipa returned')
  end
end

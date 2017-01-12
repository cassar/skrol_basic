require 'test_helper'

class RetrieveIPATest < ActiveSupport::TestCase
  test 'retrieve_ipa_word_from_wiktionary' do
    entry = 'perro'
    template = 'ˈpe.ro'
    result = retrieve_ipa_word_from_wiktionary(entry)
    assert_equal(template, result, 'incorrect ipa returned')

    entry = 'algún'
    result = retrieve_ipa_word_from_wiktionary(entry)
    assert_nil(result, 'should have returned nil')

    entry = 'intención'
    template = 'in.ten.ˈθjon'
    result = retrieve_ipa_word_from_wiktionary(entry)
    assert_equal(template, result, 'incorrect ipa returned')
  end
end

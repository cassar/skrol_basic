require 'test_helper'

class TranslateStringTest < ActiveSupport::TestCase
  # test 'String.translate should convert to bing language' do
  #   string = 'hello'.translate('en', 'es')
  #   assert_equal('Hola', string, 'bing translate not working')
  # end

  test 'String.translate should convert to IPA' do
    b_script = lang_by_name('English').base_script

    string = 'would you'.translate('en', 'ipa')
    assert_equal('wʊd juː', string, 'IPA translate not working')

    assert_raises(Invalid, 'Invalid should have raised') do
      'bull test'.translate('en', 'ipa')
    end
  end

  test 'retrieve_base_arr' do
    b_script = lang_by_name('English').base_script
    b_script.create_phonetic('IPA')

    base = b_script.words.create(entry: 'bull')
    base.create_phonetic('bʊl')

    ipa = retrieve_base_arr('en', 'bull')

    assert_not_nil(ipa, "retrieve_base_arr didn't work")
  end
end

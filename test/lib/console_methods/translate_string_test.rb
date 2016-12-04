require 'test_helper'

class TranslateStringTest < ActiveSupport::TestCase
  test 'String.translate should convert to bing language' do
    string = 'hello'.translate('en', 'es')
    assert_equal('Hola', string, 'bing translate not working')
  end

  test 'String.translate should convert to IPA' do
    lang = Language.create(name: 'English')
    b_script = lang.scripts.create(name: 'Latin script (English alphabet)',
                                   lang_code: 'en')
    b_script.create_phonetic('IPA')

    base = b_script.words.create(entry: 'bull')
    base.create_phonetic('bʊl')

    base = b_script.words.create(entry: 'dust')
    base.create_phonetic('dʌst')

    string = 'bull dust test'.translate('en', 'ipa')
    assert_equal('bʊl dʌst [none]', string, 'IPA translate not working')
  end

  test 'retrieve_base_arr should work as advertised' do
    lang = Language.create(name: 'English')
    b_script = lang.scripts.create(name: 'Latin script (English alphabet)',
                                   lang_code: 'en')
    b_script.create_phonetic('IPA')

    base = b_script.words.create(entry: 'bull')
    base.create_phonetic('bʊl')

    ipa = retrieve_base_arr('en', 'bull')

    assert_not_nil(ipa, "retrieve_base_arr didn't work")
  end
end

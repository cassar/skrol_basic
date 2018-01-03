require 'test_helper'

class LangMapTest < ActiveSupport::TestCase
  test 'lang_map validations' do
    call = 'LanguageMap.count'
    assert_difference(call, 2, 'incorrect # of maps saved') do
      LanguageMap.create(base_lang: 1, target_lang: 2)
      LanguageMap.create(base_lang: 1, target_lang: 2)
      LanguageMap.create(base_lang: 3, target_lang: 1)
      LanguageMap.create(base_lang: 3)
    end
  end

  test 'info' do
    LanguageMap.take.info
  end
end

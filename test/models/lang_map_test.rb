require 'test_helper'

class LangMapTest < ActiveSupport::TestCase
  test 'lang_map validations' do
    call = 'LangMap.count'
    assert_difference(call, 2, 'incorrect # of maps saved') do
      LangMap.create(base_lang: 1, target_lang: 2)
      LangMap.create(base_lang: 1, target_lang: 2)
      LangMap.create(base_lang: 3, target_lang: 1)
      LangMap.create(base_lang: 3)
    end
  end

  test 'base_script' do
  end

  test 'target_script' do
  end
end

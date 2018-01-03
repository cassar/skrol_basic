require 'test_helper'

class LanguageMapConsolidatorTest < ActiveSupport::TestCase
  test 'consolidate_all' do
    english_standard = Script.find(1)
    english_phonetic = Script.find(2)
    WiktionaryManager.create_metadatum(english_phonetic, ['(?<=>\/)(.*?)(?=\/)'], 'en')
    BingWordAssign.create_metadatum(english_standard, 'en')

    spanish_standard = Script.find(5)
    spanish_phonetic = Script.find(6)
    regexes = ['(?<=>\[ )(.*?)(?= \])', '(?<=C1">)(.*?)(?=\<)', '(?<=>\/)(.*?)(?=\/)']
    WiktionaryManager.create_metadatum(spanish_phonetic, regexes, 'es')
    BingWordAssign.create_metadatum(spanish_standard, 'es')

    LanguageMapConsolidator.consolidate_all(LanguageMap.find(1))
  end
end

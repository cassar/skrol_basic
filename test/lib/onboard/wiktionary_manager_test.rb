require 'test_helper'

class WiktionaryManagerTest < ActiveSupport::TestCase
  test 'process_es' do
    regexes = ['(?<=>\[ )(.*?)(?= \])', '(?<=C1">)(.*?)(?=\<)', '(?<=>\/)(.*?)(?=\/)']
    lang_code = 'es'
    WiktionaryManager.create_metadatum(Script.find(6), regexes, lang_code)
    result = WiktionaryManager.retrieve('perro', Script.find(6))
    assert_equal('ˈpe.ro', result)

    result = WiktionaryManager.retrieve('perro hola', Script.find(6))
    assert_equal('ˈpe.ro ˈo.la', result)

    # test_pair(wiki_info, , )
    # test_pair(wiki_info, 'intención', 'in.ten.ˈθjon')
    # test_pair(wiki_info, 'algún', NONE)

    # result = WiktionaryScraper.(entry, wiki_info)
    # assert_equal(translation, result, 'incorrect ipa returned')
  end

  # test 'retrieve_ipa_from_wiktionary_en' do
  #   regexes = ['(?<=>\/)(.*?)(?=\/)']
  #   lang_code = 'en'
  #   wiki_info = [regexes, lang_code]
  #
  #   test_pair(wiki_info, 'hello', 'həˈləʊ̯')
  #   test_pair(wiki_info, 'happening', 'ˈhæpɪnɪŋ')
  #   test_pair(wiki_info, 'persons', 'ˈpɜːsənz')
  # end
  #
  # test 'retrieve_ipa_from_wiktionary_it' do
  #   regexes = ['(?<=A">\[ )(.*?)(?= \]<)', '(?<=>\/)(.*?)(?=\/)']
  #   lang_code = 'it'
  #   wiki_info = [regexes, lang_code]
  #
  #   test_pair(wiki_info, 'chiuso', "'kjuso")
  #   test_pair(wiki_info, 'a', 'a')
  #   test_pair(wiki_info, 'bottiglia', "bot'tiʎʎa")
  # end
  #
  # test 'retrieve_ipa_from_wiktionary_de' do
  #   regexes = ['(?<="ipa" style="padding: 0 1px; text-decoration: none;">)(.*?)(?=\<)']
  #   lang_code = 'de'
  #   wiki_info = [regexes, lang_code]
  #
  #   test_pair(wiki_info, 'hund', 'hʊnt')
  #   test_pair(wiki_info, 'achtung', 'ˈaχtʊŋ')
  #   test_pair(wiki_info, 'deutsch', 'dɔɪ̯ʧ')
  # end
  #
  # test 'retrieve_ipa_from_wiktionary_ru' do
  #   regexes = ['(?<=nowrap;">)(.*?)(?=<)']
  #   lang_code = 'ru'
  #   wiki_info = [regexes, lang_code]
  #
  #   test_pair(wiki_info, 'канатка', 'kɐˈnatkə')
  #   test_pair(wiki_info, 'Москва', 'mɐˈskva')
  #   test_pair(wiki_info, 'Достоевский', 'dəstɐˈjefskʲɪɪ̯')
  # end
  #
  # test 'retrieve_ipa_from_wiktionary_fr' do
  #   regexes = ['(?<=>\\\\)(.*?)(?=\\\\)']
  #   lang_code = 'fr'
  #   wiki_info = [regexes, lang_code]
  #
  #   test_pair(wiki_info, 'rue', 'ʁy')
  #   test_pair(wiki_info, 'pierre', 'pjɛʁ')
  #   test_pair(wiki_info, 'fromage', 'fʁɔ.maʒ')
  # end

  # test 'retrieve_ipa_from_wiktionary_da' do
  #   regexes = ['(?<=>\/)(.*?)(?=\/<)']
  #   lang_code = 'da'
  #
  #   test_pair(wiki_info, 'dromedar', 'drome]')
  # end
end

def test_pair(wiki_info, entry, translation)
  result = WiktionaryScraper.(entry, wiki_info)
  assert_equal(translation, result, 'incorrect ipa returned')
end

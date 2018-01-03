require 'test_helper'

class ContentHelperTest < ActiveSupport::TestCase
  test 'content_add_helper' do
    # lang_map = LanguageMap.first
    #
    # target_script = lang_map.target_script
    # standard_script =
    # word_scores_obj = compile_word_scores(lang_map, target_script, standard_script)
    # compile_wfs_script(target_script, word_scores_obj)
    # compile_wls_script(target_script, word_scores_obj)
    #
    # map_wts(lang_map)
    #
    # hurdle = 2
    # standard_script = lang_map.standard_script
    #
    # content_add_helper(lang_map, hurdle)
  end

  test 'sentences_found_in' do
    word = Word.find(10)
    sentence1 = Sentence.find(2)
    sentence2 = Sentence.find(8)
    template = [sentence1, sentence2]
    result = sentences_found_in(word)
    assert_equal(template, result, 'incorrect array returned')
  end

  test 'word_in_sentence?' do
    sentence = Sentence.find(1)
    word = Word.find(3)
    assert(word_in_sentence?(word, sentence), 'method returned wrong bool')
    word = Word.find(4)
    assert(word_in_sentence?(word, sentence), 'method returned wrong bool')
    word = Word.find(1)
    assert_not(word_in_sentence?(word, sentence), 'method returned wrong bool')
  end
end

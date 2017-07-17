require 'test_helper'

class CalculateSTSTest < ActiveSupport::TestCase
  test 'compile_sts' do
    puts 'Test is empty!'
    # base_script = lang_by_name('English').base_script
    #
    # compile_chars_cfs(base_script)
    # compile_chars_cfs(base_script.phonetic)
    # compile_wfs_script(base_script)
    # compile_wls_script(base_script)
    #
    # script = lang_by_name('Spanish').base_script
    # target_sentence = Sentence.find(3)
    #
    # compile_chars_cfs(script)
    # compile_chars_cfs(script.phonetic)
    # compile_wfs_script(script)
    # compile_wls_script(script)
    #
    # lang_map = LangMap.first
    # base_script = lang_map.base_script
    #
    # script.words.each { |word| compile_wts(word, base_script, lang_map) }
    # compile_swls(script)
    #
    # compile_sts(target_sentence, lang_map)
    #
    # result = target_sentence.retrieve_score('STS', lang_map)
    # assert(result.entry.is_a?(Float), 'incorrect score returned')
    # result = target_sentence.scores.where(name: 'STS').count
    # assert_equal(1, result, 'old score was not removed')
  end

  test 'calculate_sts' do
    puts 'Test is empty!'
    # base_script = lang_by_name('English').base_script
    # base_script.sentences.where(entry: 'The car is not blue!').first
    #
    # compile_chars_cfs(base_script)
    # compile_chars_cfs(base_script.phonetic)
    # compile_wfs_script(base_script)
    # compile_wls_script(base_script)
    #
    # script = lang_by_name('Spanish').base_script
    # target_sentence =
    #   script.sentences.where(entry: 'El coche es de color azul!').first
    #
    # compile_chars_cfs(script)
    # compile_chars_cfs(script.phonetic)
    # compile_wfs_script(script)
    # compile_wls_script(script)
    #
    # lang_map = LangMap.first
    # base_script = lang_map.base_script
    #
    # script.words.each { |word| compile_wts(word, base_script, lang_map) }
    # compile_swls(script)
    #
    # result = calculate_sts(target_sentence, lang_map)
    # assert(result.is_a?(Float), 'incorrect sts score returned')
  end

  test 'return_sentence_scores' do
    puts 'Test is empty!'
    # base_script = lang_by_name('English').base_script
    #
    # compile_chars_cfs(base_script)
    # compile_chars_cfs(base_script.phonetic)
    # compile_wfs_script(base_script)
    # compile_wls_script(base_script)
    #
    # script = lang_by_name('Spanish').base_script
    # target_sentence =
    #   script.sentences.where(entry: 'El coche es de color azul!').first
    #
    # compile_chars_cfs(script)
    # compile_chars_cfs(script.phonetic)
    # compile_wfs_script(script)
    # compile_wls_script(script)
    #
    # lang_map = LangMap.first
    # base_script = lang_map.base_script
    #
    # script.words.each { |word| compile_wts(word, base_script, lang_map) }
    # compile_swls(script)
    #
    # template = 3
    # result = return_sentence_scores(target_sentence, lang_map)
    # assert_equal(template, result.count, 'incorrect scores array returned')
  end
end

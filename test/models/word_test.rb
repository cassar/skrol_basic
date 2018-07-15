require 'test_helper'

class WordTest < ActiveSupport::TestCase
  setup do
    @hello = Word.find(1)
    @hello_phon = Word.find(28)

    @bottle = Word.find(7)
    @bottiglia = Word.find(20)

    @english_std = Script.find(1)
  end

  test 'WordPhonetic phonetics' do
    assert_equal(@hello_phon, @hello.phonetic, 'phonetics not working')
  end

  test 'WordPhonetic standards' do
    assert_equal(@hello, @hello_phon.standard, 'standard not working')
  end

  test 'WordAssociate .all_associates' do
    assert_equal([@bottle], @bottiglia.all_associates)
    assert_equal([@bottiglia], @bottle.all_associates)
  end

  test 'WordAssociate new_associate' do
    holla = Word.create(entry: 'Holla', script_id: 5)
    @hello.new_associate(holla)
    assert_equal([holla], @hello.all_associates)
    assert_equal(@hello, holla.corresponding(@english_std))
  end

  # test 'Word.create and destroy' do
  #   script = Language.find_by_name('English').standard_script
  #   script2 = Language.find_by_name('Spanish').standard_script
  #
  #   assert_difference('Word.count', 3, 'Wrong number of words saved!') do
  #     script.words.create(entry: 'unique')
  #     script.words.create(entry: 'unique')
  #     script.words.create
  #
  #     script2.words.create(entry: 'unique')
  #   end
  #
  #   word = script.words.find_by_entry('apple')
  #   score = word.scores.create(map_to_id: 2, map_to_type: 'Word',
  #                              name: 'WSS', entry: 0.23)
  #
  #   assert_not_nil(score, 'Score did not save.')
  #   score_count = Score.where(name: 'WSS').count
  #   assert_equal(1, score_count, 'No scores saved.')
  #
  #   assert_not_nil(word.script, '.script method does not work.')
  #   assert_not_nil(word.language, '.language method does not work.')
  #
  #   word.destroy
  #   score_count = Score.where(name: 'WSS').count
  #   assert_equal(0, score_count, 'Score did not destroy.')
  # end
  #
  # test '.phonetic and .create_phonetic' do
  #   lang = Language.create(name: 'Chinese')
  #
  #   b_script = lang.scripts.create(name: 'Hanzi')
  #   p_script = b_script.create_phonetic('IPA')
  #
  #   b_word = b_script.words.create(entry: 'apple')
  #   p_word = ''
  #   assert_difference('Word.count', 1, 'wrong number of words saved') do
  #     p_word = b_word.create_phonetic('')
  #   end
  #
  #   assert_equal(b_word.group_id, p_word.group_id, 'assoc_id mismatch!')
  #   assert_equal(p_word, b_word.phonetic, ".phonetic doesn't work")
  #   assert_raises(ActiveRecord::RecordNotFound, 'Invalid not raised') do
  #     p_word.phonetic
  #   end
  # end
  #
  # test 'Word.phonetic_present?' do
  #   word = Language.find_by_name('English').standard_script.words.find_by_entry('bottle')
  #   assert(word.phonetic_present?, 'Wrong bool returned')
  #   word = Language.find_by_name('English').standard_script.words.find_by_entry('paper')
  #   assert_not(word.phonetic_present?, 'Wrong bool returned')
  # end
  #
  # test 'Word.standard' do
  #   phon = Word.find(30)
  #   template = Word.find(7)
  #   result = phon.standard
  #   assert_equal(template, result, 'incorrect word record returned')
  # end
  #
  # test 'Word.return_group' do
  #   word = Language.find_by_name('English').standard_script.words.find_by_entry('car')
  #
  #   assert_equal(4, word.return_group.count, 'return_group does not work')
  # end
  #
  # test 'Word.retrieve_score' do
  #   word = Language.find_by_name('Spanish').standard_script.words.find_by_entry('botella')
  #   lang_map = LanguageMap.first
  #   score = Score.where(name: 'WTS').first
  #   name = 'WTS'
  #   result = word.retrieve_score(name, lang_map)
  #   assert_equal(score, result, 'retrieve_wts failed')
  #   word = Language.find_by_name('Spanish').standard_script.words.find_by_entry('color')
  #   assert_raises(ActiveRecord::RecordNotFound, 'Invalid was not raised') do
  #     word.retrieve_score(name, lang_map)
  #   end
  # end
  #
  # test 'create_update_score' do
  # end
  #
  # test 'create_rep' do
  #   RepSent.destroy_all
  #   sentence = Sentence.first
  #   word = Word.first
  #   call = 'RepSent.count'
  #   assert_difference(call, 1, 'repsent did not save') do
  #     word.create_rep(sentence)
  #   end
  # end
end

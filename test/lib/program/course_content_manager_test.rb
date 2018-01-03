require 'test_helper'

class CourseContentManagerTest < ActiveSupport::TestCase
  setup do
    @manager = CourseContentManager.new(LanguageMap.find(1))
  end

  test 'standard_scripts' do
    temp = [Script.find(5), Script.find(1)]
    assert_equal(temp, @manager.standard_scripts)
  end

  test 'standard_words' do
    tar_stn = [Word.find(7), Word.find(8), Word.find(9)]
    bse_stn = [Word.find(1), Word.find(2), Word.find(3)]
    assert_equal(tar_stn, @manager.standard_words.first)
    assert_equal(bse_stn, @manager.standard_words.second)
  end

  test 'sentence_associates' do
    assert_equal([SentenceAssociate.find(1)], @manager.sentence_associates)
  end
end

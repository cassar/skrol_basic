require 'test_helper'

class CourseCreatorTest < ActiveSupport::TestCase
  setup do
    @en_es = LanguageMap.first
  end

  test 'create' do
    course = CourseCreator.create(@en_es)
    assert_equal(3, course.word_scores.count)
    assert_equal(1, course.sentence_scores.count)
  end
end

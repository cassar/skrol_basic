require 'test_helper'

class CourseTest < ActiveSupport::TestCase
  setup do
    @course = Course.take
  end

  test 'word_scores' do
    template = [WordScore.find(1), WordScore.find(2), WordScore.find(3)]
    assert(@course.word_scores, template)
  end

  test 'sentence_scores' do
    template = [SentenceScore.find(1)]
    assert(@course.sentence_scores, template)
  end

  test 'create' do
    word = Script.find(5).words.create(entry: 'test')
    assert_difference('WordScore.count', 1) do
      @course.word_scores.create(entry: 0.6, rank: 5, word: word)
    end
  end
end

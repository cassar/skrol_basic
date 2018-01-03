require 'test_helper'

class WordScoreTest < ActiveSupport::TestCase
  setup do
    @word_score = WordScore.find(1)
  end

  test 'course' do
    assert(@word_score.course, Course.find(1))
  end
end

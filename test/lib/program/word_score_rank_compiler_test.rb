require 'test_helper'

class WordScoreRankCompilerTest < ActiveSupport::TestCase
  setup do
    @course = Course.find(1)
  end

  test 'compile' do
    wts_scores_obj = { 1 => 0.07, 2 => 0.55 }
    assert_difference('WordScore.count', 2) do
      @word_score_compiler = WordScoreRankCompiler.compile(@course, wts_scores_obj)
    end
  end
end

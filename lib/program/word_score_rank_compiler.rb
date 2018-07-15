module WordScoreRankCompiler
  # Compiles all Rank Score for a particular map.
  def self.compile(course, wts_scores_obj)
    Helper.new(course, wts_scores_obj).compile
  end

  class Helper
    def initialize(course, wts_scores_obj)
      @course = course
      @wts_scores_obj = wts_scores_obj
      @scores_arr = []
      @scores_obj = {}
    end

    def compile
      derive_scores_arr_obj
      assign_word_ranks
    end

    private

    def derive_scores_arr_obj
      @wts_scores_obj.each_value { |wts| @scores_obj[wts] = [] }
      @wts_scores_obj.each do |word_id, wts|
        @scores_arr << wts
        @scores_obj[wts] << word_id
      end
    end

    # Assigns ranks to the words based on the scores_arr, scores_obj.
    def assign_word_ranks
      rank = 1
      @scores_arr.uniq.sort.reverse_each do |score_entry|
        @scores_obj[score_entry].each do |word_id|
          @course.word_scores.create(word_id: word_id, entry: score_entry, rank: rank)
          rank += 1
        end
      end
    end
  end
end

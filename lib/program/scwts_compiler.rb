# Compiles the Sentence Constituent Word Total Score (SCWTS) for all sentences
# in a given sentence array and updates the given psts_scores_obj
module SCWTSCompiler
  def self.compile(content_manager, wts_scores_obj, psts_scores_obj)
    standard_script = content_manager.tar_stn_spt
    helper = SCWTSHelper.new(standard_script, wts_scores_obj)
    content_manager.tar_stn_sents.each do |sentence|
      psts_scores_obj[sentence.id] += helper.score(sentence) * SCWTSW
    end
  end

  class SCWTSHelper
    def initialize(standard_script, wts_scores_obj)
      @sent_rep_compiler = SentenceRepresentationCompiler.new(standard_script)
      @wts_scores_obj = wts_scores_obj
    end

    # Calculates the Sentence Constituent Word Total Score (SCWTS) for a
    # given a target_sentence.
    def score(sentence)
      total_scores = 0
      rep_array = @sent_rep_compiler.compile(sentence)
      rep_array.each { |word| total_scores += @wts_scores_obj[word.id] }
      total_scores / rep_array.length
    end
  end
end

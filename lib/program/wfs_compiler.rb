# Calculates and stores all the Word Frequency Score (WFS) given an array of
# target stardard words and an array of target stanard sentences and updates
# the wts_scores_obj
module WFSCompiler
  def self.compile(content_manager, wts_scores_obj)
    words = content_manager.tar_stn_words
    helper = WFSCompilerHelper.new(content_manager.tar_stn_spt)
    words.each { |word| wts_scores_obj[word.id] += helper.score(word) * WFSW }
  end

  class WFSCompilerHelper
    def initialize(standard_script)
      @catalogue = derive_words_catalogue(standard_script)
      @total_words = return_word_total(@catalogue)
    end

    def score(word)
      numerator = @catalogue[word.id]
      numerator = 0 if numerator.nil?
      numerator.to_f / @total_words
    end

    private

    # {word_id => count}
    def derive_words_catalogue(script)
      catalogue = {}
      script.sentences_words.each do |sent_word|
        sent_count = catalogue[sent_word.word_id]
        sent_count = 0 if sent_count.nil?
        sent_count += 1
        catalogue[sent_word.word_id] = sent_count
      end
      catalogue
    end

    def return_word_total(catalogue)
      total = 0
      catalogue.each { |_entry, count| total += count }
      total
    end
  end
end

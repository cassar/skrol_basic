# Calculates the Sentence Word Order Score (SWOS) for a given array of
# sentences and updates the psts_scores_obj passed through.
module SWOSCompiler
  def self.compile(content_manager, psts_scores_obj)
    helper = SWOSHelper.new(content_manager)
    content_manager.sentence_associates.each do |sentence_associate|
      helper.process_sentence_associate(sentence_associate, psts_scores_obj)
    end
  end

  class SWOSHelper
    def initialize(content_manager)
      @tar_stn_spt, bse_stn_spt = content_manager.standard_scripts
      @word_assoc_compiler = WordAssociateRepresentationCompiler.new([@tar_stn_spt, bse_stn_spt])
      @sent_assoc_manager = SentenceAssociateManager.new([@tar_stn_spt, bse_stn_spt])
    end

    def process_sentence_associate(sentence_associate, psts_scores_obj)
      tar_rep, bse_rep = @word_assoc_compiler.compile(sentence_associate)
      score = score(tar_rep, bse_rep)
      target_sentence = @sent_assoc_manager.associated(@tar_stn_spt, sentence_associate)
      psts_scores_obj[target_sentence.id] += score * SWOSW
    end

    private

    def score(tar_rep, bse_rep)
      all_distances = []
      tar_rep.each_with_index do |tar_word_assoc, tar_index|
        examine_against_base(bse_rep, tar_word_assoc, tar_index, all_distances)
      end
      all_distances.sum.to_f / ((tar_rep.length + bse_rep.length) / 2)
    end

    def examine_against_base(bse_rep, tar_word_assoc, tar_index, all_distances)
      assoc_distances = []
      bse_rep.each_with_index do |bse_word_assoc, bse_index|
        next unless tar_word_assoc == bse_word_assoc
        assoc_distances << (tar_index - bse_index).abs
      end
      all_distances << assoc_distances.min unless assoc_distances.empty?
    end
  end
end

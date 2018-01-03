class WordAssociateRepresentationCompiler
  def initialize(associate_scripts)
    @script1, @script2 = associate_scripts
    @sent_assoc_manager = SentenceAssociateManager.new(associate_scripts)
    @sent_rep_compiler1 = SentenceRepresentationCompiler.new(@script1)
    @sent_rep_compiler2 = SentenceRepresentationCompiler.new(@script2)
    @word_assoc_manager = WordAssociateManager.new(associate_scripts)
  end

  attr_reader :word_assoc_manager
  attr_reader :sent_assoc_manager

  def compile(sentence_associate)
    sent1, sent2 = @sent_assoc_manager.sentences(sentence_associate)
    sent_rep1 = @sent_rep_compiler1.compile(sent1)
    sent_rep2 = @sent_rep_compiler2.compile(sent2)
    sent_assoc_rep1 = CompilerHelper.new(@word_assoc_manager).match(sent_rep1, sent_rep2)
    sent_assoc_rep2 = CompilerHelper.new(@word_assoc_manager).match(sent_rep2, sent_rep1)
    [sent_assoc_rep1, sent_assoc_rep2]
  end

  class CompilerHelper
    def initialize(word_assoc_manager)
      @word_assoc_manager = word_assoc_manager
      @sent_assoc_rep_x = []
      @winner = nil
      @runner_up = nil
    end

    def match(sent_rep_x, sent_rep_y)
      sent_rep_x.each do |word_x|
        reset_winner_and_runner_up
        @word_assoc_manager.associates(word_x).each do |word_associate|
          word_y = @word_assoc_manager.corresponding(word_x, word_associate)
          analyse_y(word_y, sent_rep_y, word_associate)
        end
        assign_associate
      end
      @sent_assoc_rep_x
    end

    private

    def analyse_y(word_y, sent_rep_y, word_associate)
      if sent_rep_y.include? word_y
        word_y_length = word_y.entry.length
        return unless (@winner[:word_y_length] < word_y_length) || @winner.nil?
        @winner = { word_y_length: word_y_length, word_associate: word_associate }
      else
        @runner_up = word_associate
      end
    end

    # choose the associate that appears in the corresponding sentence.
    def assign_associate
      word_associate = @winner[:word_associate]
      word_associate = @runner_up if word_associate.nil?
      @sent_assoc_rep_x << word_associate
    end

    def reset_winner_and_runner_up
      @winner = { word_y_length: -1 }
      @runner_up = nil
    end
  end
end

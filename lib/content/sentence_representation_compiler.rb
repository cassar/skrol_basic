class SentenceRepresentationCompiler
  def initialize(standard_script)
    words = standard_script.words
    sents_words = standard_script.sentences_words
    sents = standard_script.sentences
    @sent_to_words = derive_sent_to_words(sents, words, sents_words)
  end

  def compile(standard_sentence, word_reps = nil)
    word_reps = @sent_to_words[standard_sentence] if word_reps.nil?
    SentRepHelper.new(standard_sentence, word_reps).analyse_sentence
  end

  class SentRepHelper
    def initialize(standard_sentence, word_reps)
      @start_index = 0
      @word_reps = word_reps
      @sentence_representation = []
      @entry = standard_sentence.entry.remove_sentence_deliniators.downcase
      @entry_length = @entry.length
      @sentence = standard_sentence
    end

    def analyse_sentence
      while @start_index < @entry_length
        candidates = retrieve_candidates
        process_candidates(candidates)
      end
      @sentence_representation
    end

    def retrieve_candidates
      candidates = []
      @word_reps.each do |word|
        next unless word.entry == prospective_substring(word)
        candidates << word
      end
      candidates
    end

    def prospective_substring(word)
      @entry[@start_index, word.entry.length]
    end

    def process_candidates(candidates)
      if candidates.empty?
        @start_index += 1
      else
        winner = search_for_winner(candidates)
        @sentence_representation << winner
        @start_index += winner.entry.length
      end
    end

    def search_for_winner(candidates)
      winner = candidates.first
      candidates.each do |candidate|
        winner = candidate if candidate.entry.length > winner.entry.length
      end
      winner
    end
  end
end

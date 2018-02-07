# Updates the SentenceWord table for a particular Sentence.
class SentenceWordUpdater
  def initialize(standard_script)
    @standard_script = standard_script
    @sentences = standard_script.sentences
    words = standard_script.words
    sent_words = standard_script.sentences_words
    @sent_to_words = derive_sent_to_words(@sentences, words, sent_words)
    @sent_rep_compiler = SentenceRepresentationCompiler.new(standard_script)
    @entry_to_word = derive_entry_to_record(words)
    @authority_helper = AuthorityHelper.new(@sent_rep_compiler, @entry_to_word)
  end

  def update(sentence)
    current_words = @sent_to_words[sentence]
    current_words = [] if current_words.nil?
    authorities = @authority_helper.retrieve(sentence)
    return authorities if authorities.sort == current_words.sort
    sentence.words = authorities
    @sent_to_words[sentence] = authorities
    authorities
  end

  def update_all(corr_script = nil)
    if corr_script.nil?
      @sentences.each { |sentence| update(sentence) }
    else
      sentences = corr_script.associate_sentences(@standard_script)
      sentences.each { |sentence| update(sentence) }
    end
    nil
  end

  class AuthorityHelper
    def initialize(sent_rep_compiler, entry_to_word)
      @sent_rep_compiler = sent_rep_compiler
      @entry_to_word = entry_to_word
      @word_lengths = derive_word_lengths
      @max_length = @word_lengths.max
    end

    def retrieve(sentence)
      reset_variables(sentence)
      retrieve_candidates
      @sent_rep_compiler.compile(sentence, @candidates).uniq
    end

    private

    def retrieve_candidates
      while @start_index < @entry_length
        @end_index = @start_index + 1
        check_from_current_start_index
        @start_index += 1
      end
    end

    def check_from_current_start_index
      while @end_index <= @entry_length
        substring_size = @end_index - @start_index
        break if substring_size > @max_length
        check_substring if @word_lengths.include? substring_size
        @end_index += 1
      end
    end

    def check_substring
      substring = @entry[@start_index...@end_index]
      candidate = @entry_to_word[substring]
      @candidates << candidate unless candidate.nil?
    end

    def reset_variables(sentence)
      @candidates = []
      @start_index = 0
      @end_index = 1
      @entry = sentence.entry.downcase
      @entry_length = @entry.length
    end

    def derive_word_lengths
      word_lengths = []
      @entry_to_word.each_key do |entry|
        next if word_lengths.include? entry.length
        word_lengths << entry.length
      end
      word_lengths
    end
  end
end

class NextSentenceRetriever
  def initialize(enrolment_manager)
    @enrolment_manager = enrolment_manager
    @course_manager = enrolment_manager.course_manager
  end

  # Retrieves the next sentence a user will view given a word object
  def retrieve(target_word)
    sentences = @enrolment_manager.available_sentences(target_word)
    return nil if sentences.empty?
    SentenceAnalyser.new(sentences, @enrolment_manager).analyse
  end

  class SentenceAnalyser
    def initialize(sentences, enrolment_manager)
      @course = enrolment_manager.course
      @enrolment = enrolment_manager.enrolment
      @sentences = sentences
      @winner = nil
      @max_score = -1
      @sent_id_to_score = derive_sent_id_to_score
      @sent_id_to_word_ids, word_ids = derive_sent_id_to_word_ids
      @word_id_to_score = derive_word_id_to_score(word_ids)
    end

    def analyse
      @sentences.each { |sentence| analyse_sentence(sentence) }
      @winner
    end

    private

    def analyse_sentence(sentence)
      return unless (sts = calculate_sts(sentence)) > @max_score
      @max_score = sts
      @winner = sentence
    end

    # Returns the User Sentence Score of a particular sentence.
    def calculate_sts(sentence)
      word_ids = @sent_id_to_word_ids[sentence.id]
      word_scores = []
      word_ids.each { |word_id| word_scores << @word_id_to_score[word_id] }
      scws = (word_scores.sum / word_scores.count) * SCWTSW
      scws + @sent_id_to_score[sentence.id]
    end

    def derive_sent_id_to_score
      sentence_scores = @course.sentence_scores.where(sentence: @sentences)
      sent_id_to_score = {}
      sentence_scores.each do |score|
        sent_id_to_score[score.sentence_id] = score.entry
      end
      sent_id_to_score
    end

    def derive_sent_id_to_word_ids
      sent_id_to_word_ids = {}
      @sentences.each { |sentence| sent_id_to_word_ids[sentence.id] = [] }
      sent_words = SentencesWord.where(sentence: @sentences)
      sent_words.each { |sw| sent_id_to_word_ids[sw.sentence_id] << sw.word_id }
      [sent_id_to_word_ids, sent_words.pluck(:word_id).uniq]
    end

    def derive_word_id_to_score(word_ids)
      word_id_to_score = {}
      user_scores = @enrolment.user_scores.where(word_id: word_ids)
      user_scores_ids = user_scores.pluck(:word_id)
      course_scores = @course.word_scores.where(word_id: word_ids - user_scores_ids)
      (user_scores | course_scores).each do |score|
        word_id_to_score[score.word_id] = score.entry
      end
      word_id_to_score
    end
  end
end

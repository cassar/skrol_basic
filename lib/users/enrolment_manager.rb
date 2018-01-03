class EnrolmentManager
  def initialize(enrolment)
    @enrolment = enrolment
    @course = enrolment.course
    @course_manager = CourseManager.new(@course)
  end

  attr_reader :enrolment
  attr_reader :course
  attr_reader :course_manager

  def next_word
    score = max_score
    return score.word unless score.nil?
    word = word_from_ranks
    return word unless word.nil?
    raise Invalid, 'no more words!'
  end

  def associated_scripts
    @course_manager.associated_scripts
  end

  def available_sentences(word)
    word.sentences & @course.sentences - @enrolment.sentences
  end

  def user_score(word)
    @enrolment.user_scores.find_by(word: word)
  end

  def assign_status(target_word, status)
    score = @enrolment.user_scores.find_by word: target_word
    if score.nil?
      start_score = @course_manager.word_score(target_word).entry
      @enrolment.user_scores.create(status: status, entry: start_score,
                                    word: target_word)
      @existing_scores << target_word.id
    else
      score.update(status: status)
    end
  end

  private

  def max_score
    @enrolment.user_scores.where('entry < ? AND status = ?', ACQUIRY_POINT,
                                 TESTED).order(entry: :desc).first
  end

  def word_from_ranks
    existing_scores = @enrolment.user_scores.pluck(:word_id)
    batch_size = existing_scores.count + 1
    ranked_words = @course_manager.limited_batch(batch_size).pluck(:word_id)
    word_id = (ranked_words - existing_scores).first
    Word.find(word_id) if word_id.present?
  end
end

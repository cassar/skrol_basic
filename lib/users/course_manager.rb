class CourseManager
  def initialize(course)
    lang_map = course.language_map
    @target_script = lang_map.target_script
    @base_script = lang_map.base_script
    @course = course
  end

  attr_reader :target_script
  attr_reader :course

  def associated_scripts
    [@target_script, @base_script]
  end

  def sentence_score(sentence)
    @course.sentence_scores.find_by sentence: sentence
  end

  def word_score(word)
    @course.word_scores.find_by word: word
  end

  def limited_batch(batch_size)
    @course.word_scores.order(rank: :asc).limit(batch_size)
  end
end

module CourseCreator
  def self.create(lang_map)
    new_course = lang_map.courses.create
    content_manager = CourseContentManager.new(lang_map)
    wts_scores_obj = WTSCompiler.compile(content_manager, new_course)
    STSCompiler.compile(content_manager, wts_scores_obj, new_course)
    new_course.info
    new_course
  end
end

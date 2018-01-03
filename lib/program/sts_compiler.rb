module STSCompiler
  def self.compile(content_manager, _wts_scores_obj, course)
    # Compile blank object to store partial sentence scores
    psts_scores_obj = create_item_scores_obj(content_manager.tar_stn_sents)
    # Compile SWLS, SWOS
    compile_swls_script(content_manager.tar_stn_sents, psts_scores_obj)
    SWOSCompiler.compile(content_manager, psts_scores_obj)
    psts_scores_obj.each do |sent_id, score|
      course.sentence_scores.create(sentence_id: sent_id, entry: score)
    end
  end
end

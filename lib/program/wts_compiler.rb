# Calculates the target_word Total Score (WTS) for a particular set of target
# words and sentences compared to base words and returns the scores in an
# object of the form
# {target_word.id => wts}
# Component word scores include WCFBS, WCFBTS, WSS, WFS, WLS for all target
# words. All weights can be found in lib/constants.rb
module WTSCompiler
  def self.compile(content_manager, course)
    wts_scores_obj = create_item_scores_obj(content_manager.tar_stn_words)
    compile_wcfbs_script(content_manager.standard_words, wts_scores_obj)
    compile_wcfts_script(content_manager.tar_stn_words, wts_scores_obj)
    compile_wss_script(content_manager, wts_scores_obj)
    WFSCompiler.compile(content_manager, wts_scores_obj)
    compile_wls_script(content_manager.tar_stn_words, wts_scores_obj)
    WordScoreRankCompiler.compile(course, wts_scores_obj)
    wts_scores_obj
  end
end

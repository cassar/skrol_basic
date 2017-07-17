# Calculates the target_word Total Score (WTS) for a particular entry to a
# desired target (base) script and saves it in a new record.
# Note: Both records are in the base rather than the phonetic form.
# Will remove old record if one exists
def compile_wts(target_word, _lang_map, word_scores_obj)
  wts_score = calculate_wts(target_word, word_scores_obj)
end

# Calculates the target_word Total Score (WTS) for a particular entry to a
# desired target (base) script.
# Note: Both records are in the base rather than the phonetic form.
# Note: A hack has been implemented on the first line in the hope that sentences
# and entries with '[none]' as the phonetic entry will be pushed to the bottom.
def calculate_wts(target_word, word_scores_obj)
  # return 0.0 if target_word.phonetic == NONE # BOTTLENECK
  wts_score = 0
  scores = word_scores_obj[target_word.id]
  wts_score += scores['WCFBS'] * WCFBSW
  wts_score += scores['WCFTS'] * WCFTSW
  wts_score += scores['WFS'] * WFSW
  wts_score += scores['WLS'] * WLSW
  wts_score += scores['WSS'] * WSSW
  wts_score
end

# Calculates the target_word Total Score (WTS) for a particular entry to a
# desired target (base) script and saves it in a new record.
# Note: Both records are in the base rather than the phonetic form.
# Will remove old record if one exists
def compile_wts(target_word, base_script)
  wts_score = calculate_wts(target_word, base_script)
  target_word.create_update_score('WTS', base_script, wts_score)
end

# Calculates the target_word Total Score (WTS) for a particular entry to a
# desired target (base) script.
# Note: Both records are in the base rather than the phonetic form.
# Note: A hack has been implemented on the first line in the hope that sentences
# and entries with '[none]' as the phonetic entry will be pushed to the bottom.
def calculate_wts(target_word, base_script)
  return 0.0 if target_word.phonetic == NONE
  weights = [WCFBSW, WCFTSW, WFSW, WLSW, WSSW]
  wts_score = counter = 0
  scores = return_word_scores(target_word, base_script)
  scores.each do |score|
    wts_score += score * weights[counter]
    counter += 1
  end
  wts_score
end

# Computes all scores needed for WTS and returns them in an array.
# Compile the wcfbs, wcfts, and wss on the phonetic scripts.
def return_word_scores(target_word, base_script)
  scores = []
  scores << calculate_wcfbs(target_word, base_script.phonetic)
  scores << calculate_wcfts(target_word.phonetic)
  scores << retrieve_word_score_entry(target_word, 'WFS')
  scores << retrieve_word_score_entry(target_word, 'WLS')
  scores << calculate_wss(target_word.phonetic, base_script.phonetic)
end

# Retrieves a word score given a target word and the name of the score.
# Would only work for score that map to their own scripts such as WFS and WLS
def retrieve_word_score_entry(target_word, name)
  target_script = target_word.script
  target_word.retrieve_score(name, target_script).entry
end

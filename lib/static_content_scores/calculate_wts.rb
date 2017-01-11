# Calculates the target_word Total Score (WTS) for a particular entry to a
# desired target (base) script and saves it in a new record.
# Note: Both records are in the base rather than the phonetic form.
# Will remove old record if one exists
def compile_wts(target_word, base_script)
  wts_score = calculate_wts(target_word, base_script)
  target_word.scores.where(map_to_id: base_script.id, map_to_type: 'Script',
                           name: 'WTS').each(&:destroy)
  target_word.scores.create(map_to_id: base_script.id, map_to_type: 'Script',
                            name: 'WTS', entry: wts_score)
end

# Calculates the target_word Total Score (WTS) for a particular entry to a
# desired target (base) script.
# Note: Both records are in the base rather than the phonetic form.
def calculate_wts(target_word, base_script)
  weights = [0.05, 0.05, 0.2, 0.2, 0.5]
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
  scores << calculate_wfs(target_word)
  scores << calculate_wls(target_word)
  scores << calculate_wss(target_word.phonetic, base_script.phonetic)
end
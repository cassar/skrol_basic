# Calculates the Word Total Score (WTS) for a particular entry to a desired
# target (base) script and saves it in a new record.
def compile_wts(word, target_script)
  wts_score = calculate_wts(word, target_script)
  word.scores.create(map_to_id: target_script.id, map_to_type: 'scripts',
                     name: 'WTS', entry: wts_score)
end

# Calculates the Word Total Score (WTS) for a particular entry to a desired
# target (base) script.
def calculate_wts(word, target_script)
  weights = [0.1, 0.1, 0.1, 0.2, 0.5]
  numerator = 0
  counter = 0
  scores = return_scores_array(word, target_script)
  scores.each do |score|
    numerator += score * weights[counter]
    counter += 1
  end
  scores / 5
end

# Computes all scores needed for WTS and returns them in an array.
def return_scores_array(word, target_script)
  scores = []
  scores << calculate_wcfbs(word)
  scores << calculate_wcfts(word, target_script)
  scores << calculate_wfs(word)
  scores << calculate_wls(word)
  scores << calculate_wss(base_word, target_word)
  scores
end

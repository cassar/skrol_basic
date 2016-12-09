# Calculates the Sentence Total Score (STS) for a particular sentence and any
# number of other languages.
def calculate_sts(target_sentence, base_script)
  weights = [0.33, 0.33, 0.33]
  sts_score = 0
  counter = 0
  scores = return_sentence_scores(target_sentence, base_script)
  scores.each do |score|
    sts_score += score * weights[counter]
    counter += 1
  end
  sts_score
end

# Returns array of sentence scores given a target sentence and a base script
def return_sentence_scores(target_sentence, base_script)
  scores = []
  scores << calculate_scwts(target_sentence, base_script)
  scores << calculate_swls(target_sentence)
  scores << calculate_swos(target_sentence, base_script)
end

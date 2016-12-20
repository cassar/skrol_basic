# Will compile and save a new score record for STS from a given target_sentence
# to a give base_script. Will remove old score if present.
def compile_sts(target_sentence, base_script)
  sts_score = calculate_sts(target_sentence, base_script)
  target_sentence.scores.where(map_to_id: base_script.id,
                               map_to_type: 'Script',
                               name: 'STS').each(&:destroy)
  target_sentence.scores.create(map_to_id: base_script.id,
                                map_to_type: 'Script', name: 'STS',
                                entry: sts_score)
end

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

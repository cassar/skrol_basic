# Will compile and save a new score record for STS from a given target_sentence
# to a give base_script. Will remove old score if present.
def compile_sts(target_sentence, base_script)
  sts_score = calculate_sts(target_sentence, base_script)
  target_sentence.create_update_score('STS', base_script, sts_score)
end

# Calculates the Sentence Total Score (STS) for a particular sentence and any
# number of other languages.
def calculate_sts(target_sentence, base_script)
  weights = [SCWTSW, SWLSW, SWOSW]
  sts_score = counter = 0
  scores = return_sentence_scores(target_sentence, base_script)
  scores.each do |score|
    sts_score += score * weights[counter]
    counter += 1
  end
  sts_score
end

# Returns array of sentence scores given a target sentence and a base script
def return_sentence_scores(target_sentence, base_script)
  target_script = target_sentence.script
  scores = []
  scores << calculate_scwts(target_sentence, base_script)
  scores << target_sentence.retrieve_score('SWLS', target_script).entry
  scores << calculate_swos(target_sentence, base_script)
end

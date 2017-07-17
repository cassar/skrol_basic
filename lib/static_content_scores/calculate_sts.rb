# Calculates the Sentence Total Score (STS) for a particular sentence and any
# number of other languages.
def calculate_sts(target_sentence, base_script, swls_score, wts_entry_obj, target_entry_group_obj, base_entry_group_obj)
  weights = [SCWTSW, SWLSW, SWOSW]
  sts_score = counter = 0
  scores = return_sentence_scores(target_sentence, base_script, swls_score, wts_entry_obj, target_entry_group_obj, base_entry_group_obj)
  scores.each do |score|
    sts_score += score * weights[counter]
    counter += 1
  end
  sts_score
end

# Returns array of sentence scores given a target sentence and a base script
def return_sentence_scores(target_sentence, base_script, swls_score, wts_entry_obj, target_entry_group_obj, base_entry_group_obj)
  target_script = target_sentence.script
  scores = []
  scores << calculate_scwts(target_sentence, wts_entry_obj)
  scores << swls_score
  scores << calculate_swos(target_sentence, base_script, target_entry_group_obj, base_entry_group_obj)
end

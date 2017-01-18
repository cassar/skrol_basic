# Checks all map between base_script and target_script sentences and determines
# if they are valid ie that they all have complete ipa translations. Will either
# skip, or create a new svs score if it qualifies.
def validate_sentences(base_script, target_script)
  target_script.sentences.each do |target_sentence|
    base_sentence = target_sentence.corresponding(base_script)
    next if base_sentence.nil?
    svs = target_sentence.retrieve_svs(base_sentence)
    next if svs.present?
    if validate_map(base_sentence, target_sentence)
      create_svs(base_sentence, target_sentence)
    end
  end
end

# Makes sure that all entries associated with a base_sentence and
# target_sentence including their phonetics do not have '[none]' there by
# determining if they are complete or not.
def validate_map(base_sentence, target_sentence)
  checks = [base_sentence, base_sentence.phonetic,
            target_sentence, target_sentence.phonetic]
  checks.each { |sent| return false if sent.entry.include? NONE }
  true
end

# Creates an SVS (Sentence Verified Score) given a base_sentence and a
# target_sentence
def create_svs(base_sentence, target_sentence)
  target_sentence.scores.create(name: 'SVS', may_to_id: base_sentence.id,
                                map_to_type: 'Sentence')
end

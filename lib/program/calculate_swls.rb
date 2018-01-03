# Compiles all SWLS for a given array of sentences and updates the given
# psts_scores_obj
def compile_swls_script(sentences, psts_scores_obj)
  max_length = max_sentence_word_length(sentences)
  sentences.each do |sentence|
    score_entry = (max_length - sentence.entry.split.length).to_f / max_length
    psts_scores_obj[sentence.id] += score_entry * SWLSW
  end
end

# Computes the max sentence length (in words) of an array of sentences
def max_sentence_word_length(sentences)
  max_length = 0
  sentences.each do |sentence|
    words_length = sentence.entry.split.length
    max_length = words_length if max_length < words_length
  end
  max_length
end

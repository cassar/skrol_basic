# Calculates the Sentence Word Length Scores (SWLS) for a desired sentence.
def calculate_swls(sentence)
  max_length = max_sentence_word_length(sentence.script)
  numerator = max_length - sentence.entry.split.length
  numerator.to_f / max_length
end

# Retrieves the max sentence length in words mapped to a particular script.
def max_sentence_word_length(script)
  max_length = 0
  script.sentences.each do |sentence|
    word_length = sentence.entry.split.length
    max_length = word_length if max_length < word_length
  end
  max_length
end

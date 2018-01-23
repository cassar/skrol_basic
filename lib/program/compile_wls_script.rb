# Compute the Word Length Scores (WLS) for each word in an array of words and
# add the weighed score to the wts_scores_obj
def compile_wls_script(words, wts_scores_obj)
  max_length = max_word_length(words)
  words.each do |word|
    score = (max_length - word.entry.length.to_f) / max_length
    wts_scores_obj[word.id] += score * WLSW
  end
end

# Retrieves the max word length in an array of word records
def max_word_length(words)
  max_length = 0
  words.each do |word|
    word_length = word.entry.length
    max_length = word_length if max_length < word_length
  end
  max_length
end

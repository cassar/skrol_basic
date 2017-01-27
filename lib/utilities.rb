# Retrieves the max word length mapped to a particular script.
def max_word_length(script)
  max_length = 0
  script.words.each do |word|
    word_length = word.entry.length
    max_length = word_length if max_length < word_length
  end
  max_length
end

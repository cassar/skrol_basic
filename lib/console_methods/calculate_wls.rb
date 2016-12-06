# Calculates the Word Length Score (WLS) for a particular entry or entries and
# will create new score records to save them.
def calculate_wls(script)
  max_length = max_word_length(script)
  script.words.each do |word|
    score = compute_wls(word, max_length)
    word.scores.create(map_to_id: script.id, map_to_type: 'scripts',
                       score_name: 'WLS', score: score)
  end
end

# Computes the wls for a particular word object given a max_length
def compute_wls(word, max_length)
  word_length = word.entry.length
  numerator = max_length - word_length.to_f
  numerator / max_length
end

# Retrieves the max word length mapped to a particular script.
def max_word_length(script)
  max_length = 0
  script.words.each do |word|
    word_length = word.entry.length
    max_length = word_length if max_length < word_length
  end
  max_length
end

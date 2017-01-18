def compile_wls_script(script)
  max_length = max_word_length(script)
  script.words.each do |word|
    score = compute_wls(word, max_length)
    word.create_update_score('WLS', script, score)
  end
end

# Computes the wls for a particular word object given a max_length
def compute_wls(word, max_length)
  word_length = word.entry.length
  numerator = max_length - word_length.to_f
  numerator / max_length
end

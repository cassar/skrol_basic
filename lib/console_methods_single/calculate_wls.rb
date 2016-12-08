def calculate_wls(word)
  max_word_length = max_word_length(word.script)
  (max_word_length - word.entry.length) / max_word_length.to_f
end

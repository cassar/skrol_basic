# comiles all Rep scores from a word to all available sentences
def compile_reps(script)
  script.sentences.each do |sentence|
    sentence.entry.split_sentence.each do |entry|
      word = script.word_by_entry(entry)
      word.create_rep(sentence)
    end
  end
end

# Calculates the word frequency score (WFS) for a word and maps it to
# it's own script
def calculate_wfs(word)
  word_count = 0
  total_words = 0
  word.script.sentences.each do |sentence|
    inc_word_count, inc_total_words = count_sentence_words(word, sentence)
    word_count += inc_word_count
    total_words += inc_total_words
  end
  return 0 if total_words.zero?
  word_count.to_f / total_words
end

def count_sentence_words(word, sentence)
  word_count = 0
  word_arr = sentence.entry.split_sentence
  word_arr.each do |entry|
    word_count += 1 if entry == word.entry || entry.downcase == word.entry
  end
  [word_count, word_arr.count]
end

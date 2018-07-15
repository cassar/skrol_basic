# { sent => [word, ...], ... }
def derive_sent_to_words(sents, words, sent_words)
  sent_id_to_sent = derive_record_id_to_record(sents)
  word_id_to_word = derive_record_id_to_record(words)
  sent_to_words = {}
  sent_words.each do |sent_word|
    add_to_sent_words(sent_to_words, sent_word, sent_id_to_sent, word_id_to_word)
  end
  sent_to_words
end

def add_to_sent_words(sent_to_words, sent_word, sent_id_to_sent, word_id_to_word)
  sent = sent_id_to_sent[sent_word.sentence_id]
  word_arr = sent_to_words[sent]
  word_arr = [] if word_arr.nil?
  word_arr << word_id_to_word[sent_word.word_id]
  sent_to_words[sent] = word_arr
end

# { Sentence => SentenceScore, ... }
def derive_sent_to_sent_score(sents, scores)
  sent_id_to_score = derive_sent_id_to_score(scores)
  sent_to_sent_scores = {}
  sents.each { |sent| sent_to_sent_scores[sent] = sent_id_to_score[sent.id] }
  sent_to_sent_scores
end

# { sentence_id => SentenceScore, ... }
def derive_sent_id_to_score(scores)
  sent_id_to_scores = {}
  scores.each { |score| sent_id_to_scores[score.sentence_id] = score }
  sent_id_to_scores
end

def create_word_scores_obj(lang_map)
  word_scores_obj = {}
  script = lang_map.target_script
  script.words.each { |word| word_scores_obj[word.id] = {} }
  word_scores_obj
end

def create_sentence_scores_obj(target_script)
  sent_scores_obj = {}
  target_script.sentences.each { |sent| sent_scores_obj[sent.id] = 0.0 }
  sent_scores_obj
end

def convert_to_word_entry_obj(target_script, wts_scores_obj)
  wts_entry_obj = {}
  target_script.words.each { |word| wts_entry_obj[word.entry] = wts_scores_obj[word.id] }
  wts_entry_obj
end

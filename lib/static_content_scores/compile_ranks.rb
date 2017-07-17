# Compiles all Rank Score for a particular map.
def compile_word_ranks(lang_map, wts_scores_obj)
  scores_arr = []
  scores_obj = {}
  derive_scores_arr_obj(wts_scores_obj, scores_obj, scores_arr, lang_map)
  assign_word_ranks(scores_arr, scores_obj, lang_map)
end

# adds to a given scores_obj and score_arr and loads it with suitable
# information given a scores arr and lang_map.
def derive_scores_arr_obj(wts_scores_obj, scores_obj, scores_arr, lang_map)
  wts_scores_obj.each do |_key, value|
    scores_obj[value] = []
  end
  lang_map.target_script.words.each do |word|
    entry = wts_scores_obj[word.id]
    scores_arr << entry
    scores_obj[entry] << word.id
  end
end

# Assigns ranks to the words based on the scores_arr, scores_obj.
def assign_word_ranks(scores_arr, scores_obj, lang_map)
  Rank.where(lang_map_id: lang_map.id, entriable_type: 'Word').destroy_all
  counter = 1
  scores_arr.uniq.sort.reverse.each do |score_entry|
    scores_obj[score_entry].each do |word_id|
      Rank.create(entriable_id: word_id, entriable_type: 'Word',
                  lang_map_id: lang_map.id, entry: counter)
      counter += 1
    end
  end
end

# Applies sentence_ranks to all word_ranks given a lang map
def compile_sentence_ranks(lang_map, sent_scores_obj)
  Rank.where(lang_map_id: lang_map.id, entriable_type: 'RepSent').destroy_all
  return_word_rank_repsent(lang_map).each do |_word_id, rep_sents|
    scores_arr = []
    scores_obj = {}
    rep_sents.each do |rep_sent|
      process_sent_id(rep_sent, lang_map, scores_arr, scores_obj, sent_scores_obj)
    end
    assign_sentence_ranks(scores_arr, scores_obj, lang_map)
  end
end

# Determines whether a given rep_sent's sentence is suitable and then adds it to
# the scores_arr and scores_obj
def process_sent_id(rep_sent, _lang_map, scores_arr, scores_obj, sent_scores_obj)
  scores_arr << sent_scores_obj[rep_sent.rep_sent_id]
  scores_obj[sent_scores_obj[rep_sent.rep_sent_id]] = rep_sent
end

# Assigns sentence ranks to RepSents givens scores_arr, and scores_obj
def assign_sentence_ranks(scores_arr, scores_obj, lang_map)
  counter = 1
  scores_arr.sort.reverse.each do |score_entry|
    rep_sent = scores_obj[score_entry]
    rep_sent.create_update_rank(lang_map, counter)
    counter += 1
  end
end

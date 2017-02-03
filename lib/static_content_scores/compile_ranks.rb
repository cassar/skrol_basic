# Compiles all Rank Score for a particular map.
def compile_word_ranks(lang_map)
  scores_arr = []
  scores_obj = {}
  base_script = lang_map.base_script
  lang_map.target_script.words.each do |word|
    entry = word.retrieve_score('WTS', lang_map).entry
    scores_arr << entry
    scores_obj[entry] = word.id
  end
  assign_word_ranks(scores_arr, scores_obj, lang_map)
end

# Assigns ranks to the words based on the scores_arr, scores_obj.
# Note: if the two scores just happen to have the same entry, then only one of
# the scores will be saved.
def assign_word_ranks(scores_arr, scores_obj, lang_map)
  counter = 1
  scores_arr.sort.reverse.each do |score_entry|
    word = word_by_id(scores_obj[score_entry])
    word.ranks.create(lang_map_id: lang_map.id, entry: counter)
    counter += 1
  end
end

# Applies sentence_ranks to all word_ranks given a lang map
def compile_sentence_ranks(lang_map)
  word_ranks = retrieve_word_ranks(lang_map)
  word_ranks.each do |word_rank|
    scores_arr = []
    scores_obj = {}
    word_rank.entriable.rep_sents.each do |rep_sent|
      process_sent_id(rep_sent, lang_map, scores_arr, scores_obj)
    end
    assign_sentence_ranks(scores_arr, scores_obj, lang_map)
  end
end

# Determines whether a given rep_sent's sentence is suitable and then adds it to
# the scores_arr and scores_obj
def process_sent_id(rep_sent, lang_map, scores_arr, scores_obj)
  phonetic_entry = sentence_by_id(rep_sent.rep_sent_id).phonetic.entry
  return if (phonetic_entry.include? NONE) || (phonetic_entry.length > 40)
  score_entry = retrieve_sts(rep_sent.rep_sent_id, lang_map).entry
  scores_arr << score_entry
  scores_obj[score_entry] = rep_sent
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

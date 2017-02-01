# Compiles all Rank Score for a particular map.
def compile_ranks(lang_map)
  scores_arr = []
  scores_obj = {}
  base_script = lang_map.base_script
  lang_map.target_script.words.each do |word|
    entry = word.retrieve_score('WTS', lang_map).entry
    scores_arr << entry
    scores_obj[entry] = word.id
  end
  assign_ranks(scores_arr, scores_obj, lang_map)
end

# Assigns ranks to the words based on the scores_arr, scores_obj.
# Note: if the two scores just happen to have the same entry, then only one of
# the scores will be saved.
def assign_ranks(scores_arr, scores_obj, lang_map)
  counter = 1
  scores_arr.sort.reverse.each do |score_entry|
    word = word_by_id(scores_obj[score_entry])
    word.ranks.create(lang_map_id: lang_map.id, entry: counter)
    counter += 1
  end
end

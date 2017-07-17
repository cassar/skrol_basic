# Will return an object of key word rank and value an array of related repsents
def return_word_rank_repsent(lang_map)
  rank_repsent_obj = {}
  Rank.where(entriable_type: 'Word', lang_map_id: lang_map.id).each do |rank|
    rank_repsent_obj[rank.entriable_id] = []
  end
  RepSent.all.each do |rep_sent|
    next if rank_repsent_obj[rep_sent.word_id].nil?
    rank_repsent_obj[rep_sent.word_id] << rep_sent
  end
  rank_repsent_obj
end

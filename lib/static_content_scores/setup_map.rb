# Sets up map for use in web app, from base_lang to target_lang
# (will delete old scores)
def setup_map(lang_map)
  # Retrieve scripts
  target_script = lang_map.target_script
  base_script = lang_map.base_script

  # Create an object that contains the constituent scores of all words
  word_scores_obj = compile_word_scores(lang_map, target_script, base_script)

  # Find and store all Reperesentative Sentences
  compile_reps(target_script)

  # Compile Word Total Scores (WTS)
  wts_scores_obj = map_wts(lang_map, word_scores_obj)

  # Compile Word Ranks to aid search
  compile_word_ranks(lang_map, wts_scores_obj)

  # Compile blank object to store sentence scores
  swl_scores_obj = create_sentence_scores_obj(target_script)

  # Compile Sentence Word Length Scores (SWLS)
  compile_swls(target_script, swl_scores_obj)

  # Compile Sentence Total Scores (STS)
  sent_scores_obj = map_sts(target_script, base_script, swl_scores_obj, wts_scores_obj)

  # Compile Sentence Ranks to aid search
  compile_sentence_ranks(lang_map, sent_scores_obj)
end

# Compiles all word scores and return an object with
def compile_word_scores(lang_map, target_script, base_script)
  # Establish characters (CFS)
  all_char_scores = compile_char_scores(target_script, base_script)

  # Create empty word scores object
  word_scores_obj = create_word_scores_obj(lang_map)

  # Compile objects with base entries to group id
  base_entries = compile_base_to_group_catalogue(base_script)
  return_word_obj(target_script, base_script, word_scores_obj, all_char_scores, base_entries)
end

# Complies the CFS for all scripts under a given lang_map
def compile_char_scores(target_script, base_script)
  all_char_scores = {}
  scripts = [base_script, base_script.phonetic,
             target_script, target_script.phonetic]
  scripts.each { |script| all_char_scores[script.id] = compile_chars_cfs(script) }
  all_char_scores
end

def return_word_obj(target_script, base_script, word_scores_obj, all_char_scores, base_entries)
  # Populate word scores object
  target_script.words.each do |target_word|
    compile_wcfbs(target_word, base_script, word_scores_obj, all_char_scores)
    compile_wcfts(target_word, word_scores_obj, all_char_scores)
    compile_wss(target_word, word_scores_obj, base_entries)
  end
  compile_wfs_script(target_script, word_scores_obj)
  compile_wls_script(target_script, word_scores_obj)
  word_scores_obj
end

# Compiles the WTSs for a given lang_map
def map_wts(lang_map, word_scores_obj)
  wts_scores_obj = create_word_scores_obj(lang_map)
  lang_map.target_script.words.each do |target_word|
    wts_scores_obj[target_word.id] = compile_wts(target_word, lang_map, word_scores_obj)
  end
  wts_scores_obj
end

# Compiles the STSs for a given lang_map
def map_sts(target_script, base_script, swl_scores_obj, wts_scores_obj)
  sent_scores_obj = create_sentence_scores_obj(target_script)
  wts_entry_obj = convert_to_word_entry_obj(target_script, wts_scores_obj)
  target_entry_group_obj = create_entry_group_obj(target_script)
  base_entry_group_obj = create_entry_group_obj(base_script)
  target_script.sentences.each { |sent| sent_scores_obj[sent.id] = calculate_sts(sent, base_script, swl_scores_obj[sent.id], wts_entry_obj, target_entry_group_obj, base_entry_group_obj) }
  sent_scores_obj
end

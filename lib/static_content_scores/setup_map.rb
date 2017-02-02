# Sets up map for use in web app, from base_lang to target_lang
# (will delete old scores)
def setup_map(lang_map)
  # Establish characters (CFS)
  establish_chars(lang_map)

  # Compile Word Frequency (WFS) and Word Length (WLS) scores, and Reps (REP)
  target_script = lang_map.target_script
  compile_wfs_script(target_script)
  compile_wls_script(target_script)
  compile_reps(target_script)

  # Compile Word Total Scores (WTS)
  map_wts(lang_map)
  # Compile Word Ranks to aid search
  compile_word_ranks(lang_map)

  # Compile Sentence Word Length Scores (SWLS)
  compile_swls(target_script)

  # Compile Sentence Total Scores (STS)
  map_sts(lang_map)
  # Compile Sentence Ranks to aid search
  compile_sentence_ranks(lang_map)
end

# Complies the CFS for all scripts under a given lang_map
def establish_chars(lang_map)
  scripts = [lang_map.base_script, lang_map.base_script.phonetic,
             lang_map.target_script, lang_map.target_script.phonetic]
  scripts.each { |script| compile_chars_cfs(script) }
end

# Compiles the WTSs for a given lang_map
def map_wts(lang_map)
  lang_map.target_script.words.each { |word| compile_wts(word, lang_map) }
end

# Compiles the STSs for a given lang_map
def map_sts(lang_map)
  lang_map.target_script.sentences.each { |sent| compile_sts(sent, lang_map) }
end

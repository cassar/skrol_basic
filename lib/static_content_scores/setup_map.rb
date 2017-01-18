# Sets up map for use in web app, from base_lang to target_lang
# (will delete old scores)
def setup_map(base_lang, target_lang)
  # Establish characters (CFS)
  establish_chars(base_lang, target_lang)

  # Compile Word Frequency (WFS) and Word Length (WLS) scores
  target_script = target_lang.base_script
  compile_wfs_script(target_script)
  compile_wls_script(target_script)

  # Compile Word Total Scores (WTS)
  map_wts(base_lang, target_lang)

  # Compile Sentence Total Scores (STS)
  map_sts(base_lang, target_lang)
end

# Complies the CFS for all scripts under a give base_lang and target_lang
def establish_chars(base_lang, target_lang)
  scripts = [base_lang.base_script, base_lang.phonetic_script,
             target_lang.base_script, target_lang.phonetic_script]
  scripts.each { |script| compile_chars_cfs(script) }
end

# Compiles the WTSs for a given base_lang and target_lang
def map_wts(base_lang, target_lang)
  base = base_lang.base_script
  target_lang.base_script.words.each { |word| compile_wts(word, base) }
end

# Compiles the STSs for a given base_lang and target_lang
def map_sts(base_lang, target_lang)
  base = base_lang.base_script
  target_lang.base_script.sentences.each { |sent| compile_sts(sent, base) }
end

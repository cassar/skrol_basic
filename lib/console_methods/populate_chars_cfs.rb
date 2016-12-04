# Populates the characters table and Computes the Character Frequency Scores
# (CFS) for all characters used by a particular script in a particular language
# storing results in the scores table.
def populate_chars_cfs(lang, script)
  return if Word.where(language: lang).count < 1
  catalogue = derive_chars_catalogue(lang, script)
  total = create_chars_return_total(catalogue, lang, script)
  create_cfs_scores(catalogue, lang, script, total)
end

# First clears all old char records from a particular language and script.
# Then creates new ones given catalogue and same language and script.
# Will return total characters in sample for use in CFS computation.
def create_chars_return_total(catalogue, lang, script)
  Character.where(language: lang, script: script).each(&:destroy)
  total = 0
  catalogue.each do |key, value|
    Character.create(entry: key, language: lang, script: script)
    total += value
  end
  total
end

# creates new CFS scores for all keys value pairs in a catalogue object given
# language_key, script string, integer total characters in catalogue.
def create_cfs_scores(catalogue, lang, script, total)
  catalogue.each do |key, value|
    char = Character.where(entry: key, language: lang, script: script).first
    next if char.nil?
    score = value.to_f / total
    char.scores.create(map_to: lang, score_name: 'CFS', score: score)
  end
end

# Adds chars to catalogue object, increments existing entry by 1 if already
# present.
def add_chars_to_catalogue(word, script, catalogue)
  char_arr = word[script].scan(/./)
  char_arr.each do |char|
    if catalogue[char].nil?
      catalogue[char] = 1
    else
      catalogue[char] += 1
    end
  end
end

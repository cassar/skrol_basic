# Populates the characters table and Computes the Character Frequency Scores
# (CFS) for all characters used by a particular script in a particular language
# storing results in the scores table. (Will destroy old scores)
def compile_chars_cfs(script)
  catalogue = derive_chars_catalogue(script)
  total = create_chars_return_total(catalogue, script)
  create_cfs_scores(catalogue, script, total)
end

# First, clears all old char records from a particular language and script.
# Then creates new ones given catalogue and script.
# Will return total characters in sample for use in CFS computation.
def create_chars_return_total(catalogue, script)
  Character.where(script_id: script.id).each(&:destroy)
  total = 0
  catalogue.each do |key, value|
    script.characters.create(entry: key)
    total += value
  end
  total
end

# creates new CFS scores for all keys value pairs in a catalogue object given
# language_key, script string, integer total characters in catalogue.
def create_cfs_scores(catalogue, script, total)
  catalogue.each do |key, value|
    char = Character.where(entry: key, script_id: script.id).first
    raise Invalid, "No char '#{key}' for that script on record!" if char.nil?
    score = value.to_f / total
    score = char.scores.create(map_to_id: script.id, map_to_type: 'scripts',
                               name: 'CFS', entry: score)
  end
end

# Takes a script record and return a catalogue object with all the characters
# used in the word records of that script along with its corresponding count.
def derive_chars_catalogue(script)
  catalogue = {}
  Word.where(script_id: script.id).each do |word|
    add_chars_to_catalogue(word, catalogue)
  end
  catalogue
end

# Adds chars to catalogue object, increments existing entry by 1 if already
# present.
def add_chars_to_catalogue(word, catalogue)
  char_arr = word.entry.scan(/./)
  char_arr.each do |char|
    if catalogue[char].nil?
      catalogue[char] = 1
    else
      catalogue[char] += 1
    end
  end
end

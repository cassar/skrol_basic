# Calculates and stores all the Word Frequency Score (WFS) for a particular
# script.
def compile_wfs_script(script)
  raise Invalid, 'No words attached to script!' if script.words.count < 1
  catalogue = derive_words_catalogue(script)
  total_words = return_word_total(catalogue)
  assign_wfs(script, catalogue, total_words)
end

# Takes a script record and return a catalogue object with all the words
# used in the sentence records of that script along with its corresponding count
def derive_words_catalogue(script)
  catalogue = {}
  Sentence.where(script_id: script.id).each do |sentence|
    add_words_to_catalogue(sentence, catalogue)
  end
  catalogue
end

# Adds chars to catalogue object, increments existing entry by 1 if already
# present.
def add_words_to_catalogue(sentence, catalogue)
  word_arr = sentence.entry.gsub(/(\.|\!|\?)/, '').split
  word_arr.each do |word|
    if catalogue[word.downcase].nil?
      catalogue[word.downcase] = 1
    else
      catalogue[word] += 1 unless word.nil?
    end
  end
end

# Returns the total of all values in an object called catalogue
def return_word_total(catalogue)
  total = 0
  catalogue.each do |_key, value|
    total += value
  end
  total
end

# Creates new WFS score record for all matching word records belonging to a
# script
def assign_wfs(script, catalogue, total_words)
  catalogue.each do |key, value|
    word = return_word(script, key)
    next if word.nil?
    word.scores.create(map_to_id: script.id, map_to_type: 'scripts',
                       name: 'WFS', entry: value.to_f / total_words)
  end
end

# Returns word record associated with an entry.
# Will search for capitalized version if it can't find first version.
def return_word(script, entry)
  word = script.words.where(entry: entry).first
  word = script.words.where(entry: entry.capitalize).first if word.nil?
  word
end

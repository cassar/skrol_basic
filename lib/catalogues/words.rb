# Takes a script record and return a catalogue object with all the words
# used in the sentence records of that script along with its corresponding count
def derive_words_catalogue(script)
  catalogue = {}
  script.sentences.each do |sentence|
    add_words_to_catalogue(sentence, catalogue)
  end
  catalogue
end

# Adds chars to catalogue object, increments existing entry by 1 if already
# present.
def add_words_to_catalogue(sentence, catalogue)
  entry_arr = sentence.entry.split_sentence
  entry_arr.each do |entry|
    if catalogue[entry].nil?
      catalogue[entry] = 1
    else
      catalogue[entry] += 1 unless catalogue[entry].nil?
    end
  end
end

# Returns a catalogue of type {entry: entry_count} given a base_script
def derive_word_entry_count_catalogue(base_script)
  count_catalogue = {}
  base_script.words.each do |word|
    entry = word.entry
    if count_catalogue[entry].nil?
      count_catalogue[entry] = 1
    else
      count_catalogue[entry] += 1
    end
  end
  count_catalogue
end

# Returns a catalogue of type {word_entry: word_id}
# Will first check for duplicates
def derive_word_entry_catalogue(base_script)
  check_no_dup_entries(base_script)
  entry_catalogue = {}
  base_script.words.each { |word| entry_catalogue[word.entry] = word.id }
  entry_catalogue
end

# First need to make sure there are no duplicate base_words in script
# Compile catalogue entry => word.id
def check_no_dup_entries(base_script)
  if base_script.parent_script_id.present?
    raise Invalid, "script_id: #{base_script.id} not a base_script!"
  end
  count_catalogue = derive_word_entry_count_catalogue(base_script)
  return unless analyse_count_catalogue(count_catalogue)
  puts "run 'remove_dupilacte_words(base_script)' to remove duplicate words."
end

# Will analyse given count_catalogue and notify of any duplicates.
# Will return true if any duplicates were found false otherwise.
def analyse_count_catalogue(count_catalogue)
  duplicates_found = false
  count_catalogue.each do |key, value|
    if value != 1
      puts "entry '#{key}' was found in #{value} records"
      duplicates_found = true
    end
  end
  duplicates_found
end

def compile_base_to_group_catalogue(base_script)
  base_entries = {}
  base_script.words.each { |word| base_entries[word.group_id] = word.entry }
  base_entries
end

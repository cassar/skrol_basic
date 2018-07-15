# Returns a catalogue of type {entry: entry_count} given a script
def derive_word_entry_count_catalogue(script)
  count_catalogue = {}
  script.words.each do |word|
    count_catalogue[word.entry] = 0 if count_catalogue[word.entry].nil?
    count_catalogue[word.entry] += 1
  end
  count_catalogue
end

# Returns a catalogue of type {word_entry: word_id}
# Will first check for duplicates
def derive_word_entry_catalogue(standard_script)
  check_no_dup_entries(standard_script)
  entry_catalogue = {}
  standard_script.words.each { |word| entry_catalogue[word.entry] = word.id }
  entry_catalogue
end

# First need to make sure there are no duplicate standard_words in script
# Compile catalogue entry => word.id
def check_no_dup_entries(standard_script)
  if standard_script.standard_id.present?
    raise StandardError, "script_id: #{standard_script.id} not a standard_script!"
  end
  count_catalogue = derive_word_entry_count_catalogue(standard_script)
  return unless analyse_count_catalogue(count_catalogue)
  puts "run 'remove_dupilacte_words(standard_script)' to remove duplicate words."
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

# Creates an object { phon_word => std_word_entry }
def derive_phon_word_to_std_entry(standard_script, new_words)
  std_id_to_std_entry_obj = {}
  standard_script.words.each do |std_word|
    std_id_to_std_entry_obj[std_word.id] = std_word.entry
  end
  phon_word_to_std_entry = {}
  new_words.each do |new_word|
    phon_word_to_std_entry[new_word] = std_id_to_std_entry_obj[new_word.assoc_id]
  end
  phon_word_to_std_entry
end

# { std_entry => phn_entry }
def derive_std_entry_to_phn_entry(standard_script, phonetic_script)
  std_id_to_std_word = derive_record_id_to_record(standard_script.words)
  phn_id_to_phn_word = derive_record_id_to_record(phonetic_script.words)
  std_entry_to_phn_entry = {}
  standard_script.phonetic_word_phonetics.each do |word_phonetic|
    std_entry = std_id_to_std_word[word_phonetic.standard_id].entry
    phn_entry = phn_id_to_phn_word[word_phonetic.phonetic_id].entry
    std_entry_to_phn_entry[std_entry] = phn_entry
  end
  std_entry_to_phn_entry
end

# { word => [sent, ...]}
def derive_word_to_sents(sents, words, sent_words)
  sent_id_to_sent = derive_record_id_to_record(sents)
  word_id_to_word = derive_record_id_to_record(words)
  word_to_sents = {}
  sent_words.each do |sent_word|
    add_to_word_to_sents(word_to_sents, sent_word, sent_id_to_sent, word_id_to_word)
  end
  word_to_sents
end

def add_to_word_to_sents(word_to_sents, sent_word, sent_id_to_sent, word_id_to_word)
  word = word_id_to_word[sent_word.word_id]
  sent = sent_id_to_sent[sent_word.sentence_id]
  return if word.nil? || sent.nil?
  sent_arr = word_to_sents[word]
  sent_arr = [] if sent_arr.nil?
  sent_arr << sent
  word_to_sents[word] = sent_arr
end

# { Word => WordScore, ... }
def derive_word_to_word_score(words, scores)
  word_id_to_score = derive_word_id_to_score(scores)
  word_to_word_score = {}
  words.each { |word| word_to_word_score[word] = word_id_to_score[word.id] }
  word_to_word_score
end

# { word_id => WordScore, ... }
def derive_word_id_to_score(scores)
  word_id_to_scores = {}
  scores.each { |score| word_id_to_scores[score.word_id] = score }
  word_id_to_scores
end

# Filters out word records that do not have an acceptable phonetic equivalent
def filter_words(stds, phons)
  new_stds = []
  new_phons = []
  stds_map = {}
  phons.each { |phon| new_phons << phon unless phon.entry.include? NONE }
  stds.each { |std| stds_map[std.id] = std }
  new_phons.each { |new_phon| new_stds << stds_map[new_phon.assoc_id] }
  [new_stds, new_phons]
end

# Filters out sentence records that do not have a phonetic equivalent
def filter_sents(stds, phons)
  new_stds = []
  new_phons = []
  stds_map = {}
  phons.each { |phon| new_phons << phon unless phon.entry.include? NONE }
  stds.each { |std| stds_map[std.group_id] = std }
  new_phons.each { |new_phon| new_stds << stds_map[new_phon.group_id] }
  [new_stds, new_phons]
end

# Filters two arrays of sentences to make sure each sentence has a corresponding
# sentence in the other group
def filter_groups(target_sents, base_sents)
  group_to_base_sents = create_group_sent_obj(base_sents)
  new_targets = []
  new_bases = []
  target_sents.each do |target_sent|
    next if group_to_base_sents[target_sent.group_id].nil?
    new_targets << target_sent
    new_bases << group_to_base_sents[target_sent.group_id]
  end
  [new_targets, new_bases]
end

# Removes all words that do not have representative sentences form words
# parameter. Expectes rep_sents to be an object of the form...
# {word.id => [sent.id, ..]}
def remove_no_reps(words, rep_sents)
  new_words = {}
  words.each { |word| new_words[word.id] = words[word.id] unless rep_sents[word.id].empty? }
  new_words
end

# Takes a language and returns the number of valid sentences and words
def valid_ipa_entry_count(language)
  phon = language.phonetic_script
  sent_count = 0
  word_count = 0
  phon.sentences.each { |sent| sent_count += 1 unless sent.entry.include? NONE }
  phon.words.each { |word| word_count += 1 unless word.entry.include? NONE }
  [sent_count, word_count]
end

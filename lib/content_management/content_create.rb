# Validates a language to make sure it is ready to map_to another language.
def pre_map_validate(language)
  base_script = language.base_script
  missing_words_filler(base_script)
  remove_duplicates(base_script)
  thread_fill_ipa(base_script)
  derive_phonetics(base_script)
end

# Creates two new word records, one for the base and one for the phonetic
# versions of a word. A group_id will also be set if supplied.
def create_word(base_entry, phonetic_entry, base_script, group_id = nil)
  english = lang_by_name('English').base_script
  if group_id.nil? && base_script != english
    group_id = retrieve_english_id(base_entry, base_script)
  end
  ActiveRecord::Base.transaction do
    base_word = base_script.words.create(entry: base_entry, group_id: group_id)
    base_word.create_phonetic(phonetic_entry)
  end
end

# Updates both the phonetic and base entries of a given base_word
def update_word(base_entry, ipa_entry, base_word)
  ActiveRecord::Base.transaction do
    base_word.update(entry: base_entry)
    base_word.phonetic.update(entry: ipa_entry)
  end
end

# Creates two new sentence records, one for the base and one for the phonetic
# versions of a word. Will throw an error if the base_entry cannot be translated
# to phonetic and will save neither entry.
def create_sentence(base_entry, base_script, group_id = nil)
  base = nil
  ActiveRecord::Base.transaction do
    base = base_script.sentences.create(entry: base_entry, group_id: group_id)
    base.create_phonetic
  end
  base
end

# Removes word and its phonetic equivalent
def remove_word(word)
  phon = Word.find_by assoc_id: word.id
  phon.destroy unless phon.nil?
  word.destroy
end

# Loops through all sentences and identifies any words in the sentence that are
# not in the words table.
def missing_words_filler(script)
  entries = []
  script.sentences.each do |sentence|
    sentence.entry.split_sentence.each { |entry| entries << entry }
  end
  entries.uniq.each do |entry|
    create_word(entry, NEW, script, 0) unless word_present?(entry, script)
  end
end

# Goes through the base_script words, check for duplicates and removes them
def remove_duplicates(base_script)
  entries = derive_words_catalogue(base_script)
  entries.each do |_key, value|
    next if value < 2
    words = base_script.words.where(entry: key)
    word = words.first
    words.each do |w|
      next if w == word
      remove_word(w)
    end
  end
end

# Starts 10 threads to fill in IPA equivalent words in a given base script.
def thread_fill_ipa(base_script)
  10.times do
    Thread.new { fill_in_ipa_entries(base_script) }
  end
end

# Fills in IPA entries of word record given an array of base word records.
def fill_in_ipa_entries(base_script)
  loop do
    phon_word = base_script.phonetic.words.find_by entry: NEW
    break if phon_word.nil?
    phon_word.update(entry: CHECK)
    base_entry = phon_word.base.entry
    ipa_entry, entry = search_for_ipa_entry(base_entry, base_script)
    update_word(entry, ipa_entry, phon_word.base)
  end
end

# Starts 10 threads to begin filling in the group_id of all words who have a
# group_id of zero.
def thread_fill_word_group(target_script)
  english = lang_by_name('English').base_script
  10.times do
    Thread.new { fill_in_group_ids(target_script, english) }
  end
end

# Takes a word whose word.group_id is 0 and finds a suitable group_id if one
# is available
def fill_in_group_ids(target_script, english)
  loop do
    word = target_script.words.where(group_id: 0).take
    break if word.nil?
    word.update(group_id: -1)
    find_assign_group_id(word, english)
  end
end

# Searches for an existing english group_id if one is there and assignes it to
# given word, if non group_id is found, the group_id is just set to its own id
def find_assign_group_id(word, english)
  english_entry = word.entry.translate(target_script.lang_code, 'en')
  english_word = english.words.where(entry: english_entry).take
  if english_word.nil?
    update_group_id(word, word.id)
  else
    update_group_id(word, english_word.id)
  end
end

# Updates the group_id of a given word and its phonetic equivalent.
def update_group_id(word, group_id)
  word.update(group_id: group_id)
  word.phonetic.update(group_id: group_id)
end

# Checks to see if any phonetic words have mistakingly pulled html.
def check_for_html(phonetic_script)
  errors = ''
  phonetic_script.words.each do |word|
    errors << "id: #{word.id} has html\n" if word.entry.include? '>'
  end
  puts errors
end

# Converts a sentence entry into the international phonetic alphabet and saves
# it as a new phonetic entry.
def derive_phonetics(base_script)
  phonetic_script = base_script.phonetic
  base_script.sentences.each do |sentence|
    phonetic = sentence.entry.translate(base_script.lang_code, 'ipa')
    sentence.update(group_id: sentence.id) if sentence.group_id.nil?
    create_update_sentence(phonetic, phonetic_script, sentence.group_id)
  end
end

# Creates or updates a new sentence given an entry, script and group_id
def create_update_sentence(entry, script, group_id)
  sentence = script.sentences.find_by group_id: group_id
  if sentence.nil?
    new_s = script.sentences.create(entry: entry, group_id: group_id)
  else
    sentence.update(entry: entry)
  end
end

# Goes through all base words and checks if there is a phonetic word associated
# with it, if not it will attempt to create one.
def fill_in_phonetics(language)
  base_script = language.base_script
  phon_script = base_script.phonetic
  base_script.words.each do |base_word|
    phon = phon_script.words.find_by assoc_id: base_word.id
    next unless phon.nil?
    fill_single_phonetic(base_word, base_script)
  end
end

# Searches for and creates a new phonetic entry.
def fill_single_phonetic(base_word)
  ipa_entry, entry = search_for_ipa_entry(base_word.entry, base_script)
  base_word.update(entry: entry)
  base_word.create_phonetic(ipa_entry)
end

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

# Creates 4 sentence entries given a base entry, a base_script and target_script
# Will only save all or nothing if the sentences can be translated to phonetic.
def create_slide(base_entry, base_script, target_script)
  ActiveRecord::Base.transaction do
    base = create_sentence(base_entry, base_script)
    target_entry =
      base_entry.translate(base_script.lang_code, target_script.lang_code)
    create_sentence(target_entry, target_script, base.group_id)
  end
end

def thread_fill_ipa(base_script)
  10.times do
    Thread.new { fill_in_ipa_entries(base_script) }
  end
end

# Fills in IPA entries of word record given an array of base word records.
def fill_in_ipa_entries(base_script)
  loop do
    phon_word = base_script.phonetic.words.where(entry: NEW).first
    break if phon_word.nil?
    phon_word.update(entry: CHECK)
    base_entry = phon_word.base.entry
    ipa_entry, entry = search_for_ipa_entry(base_entry, base_script)
    update_word(entry, ipa_entry, phon_word.base)
  end
end

# Converts a sentence entry into the international phonetic alphabet and saves
# it as a new entry.
def derive_phonetics(lang)
  base_script = lang.base_script
  phonetic_script = lang.phonetic_script
  base_script.sentences.each do |sentence|
    phonetic = sentence.entry.translate(base_script.lang_code, 'ipa')
    sentence.update(group_id: sentence.id) if sentence.group_id.nil?
    create_update_sentence(phonetic, phonetic_script, sentence.group_id)
  end
end

# Creates or updates a new sentence given an entry, script and group_id
def create_update_sentence(entry, script, group_id)
  sentence = script.sentences.where(group_id: group_id).first
  if sentence.nil?
    new_s = script.sentences.create(entry: entry, group_id: group_id)
  else
    sentence.update(entry: entry)
  end
end

# Goes through all base words and checks if there in a phonetic word accosiated
# with it, if not it will attempt to create one.
def fill_in_phonetics
  Language.all.each do |lang|
    base_script = lang.base_script
    phon_script = base_script.phonetic
    base_script.words.each do |base_word|
      phon = phon_script.words.where(assoc_id: base_word.id).first
      next unless phon.nil?
      fill_single_phonetic(base_word, base_script)
    end
  end
end

# Searches for and creates a new phonetic entry.
def fill_single_phonetic(base_word)
  ipa_entry, entry = search_for_ipa_entry(base_word.entry, base_script)
  base_word.update(entry: entry)
  base_word.create_phonetic(ipa_entry)
end

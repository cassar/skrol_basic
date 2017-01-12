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

# Retrieves the english group id of a foreign word if available.
def retrieve_english_id(base_entry, base_script)
  english = lang_by_name('English').base_script
  english_entry =
    base_entry.translate(base_script.lang_code, english.lang_code)
  english_word = return_word(english, english_entry)
  english_word.group_id unless english_word.nil?
end

# Fills in Spanish phonetic words.
def fill_in_spanish_ipa
  script = lang_by_name('Spanish').base_script
  entries = missing_words_report(script)
  entries.each do |base_entry|
    ipa_entry = retrieve_ipa_word_from_wiktionary(base_entry)
    next if ipa_entry.nil?
    create_word(base_entry, ipa_entry, script)
  end
end

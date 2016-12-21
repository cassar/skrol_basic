class Invalid < StandardError
end

# Retrieves the max word length mapped to a particular script.
def max_word_length(script)
  max_length = 0
  script.words.each do |word|
    word_length = word.entry.length
    max_length = word_length if max_length < word_length
  end
  max_length
end

# Returns a language record given a name
def lang_by_name(name)
  lang = Language.where(name: name).first
  raise Invalid, "No language with #{name} found!" if lang.nil?
  lang
end

# Returns a User record given a name
def user_by_name(name)
  user = User.where(name: name).first
  raise Invalid, "No user with #{name} found!" if user.nil?
  user
end

# Translates all sentences under a particular base script to a given target
# script and creates a new record.
def translate_all_sentences(base_lang, target_lang)
  base_script = base_lang.base_script
  target_script = target_lang.base_script
  base_script.sentences.each do |sentence|
    translated = sentence.entry.translate(base_script.lang_code,
                                          target_script.lang_code)
    sentence.update(group_id: sentence.id) if sentence.group_id.nil?
    create_update_sentence(translated, target_script, sentence.group_id)
  end
end

# Converts a sentence entry into the international phonetic alphabet and save
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

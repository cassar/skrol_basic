# Retrieves the max word length mapped to a particular script.
def max_word_length(script)
  max_length = 0
  script.words.each do |word|
    word_length = word.entry.length
    max_length = word_length if max_length < word_length
  end
  max_length
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

# Returns word record associated with an entry.
# Will search for capitalized version if it can't find first version.
def return_word(script, entry)
  word = script.words.where(entry: entry).first
  word = script.words.where(entry: entry.capitalize).first if word.nil?
  word = script.words.where(entry: entry.downcase).first if word.nil?
  word
end

# Returs a new work score entry given the metric and score records
def return_user_word_score(metric, score)
  new_entry = score.entry
  new_entry += NORMAL_BONUS * return_speed_adjustment(metric.speed)
  new_entry -= PAUSE_PENALTY if metric.pause
  new_entry -= HOVER_PENALTY if metric.hover
  new_entry += HIDE_BONUS if metric.hide
  new_entry = fix_new_entry(new_entry)
end

# Makes sure entry floor is 0.0 and ceiling is 1.0
def fix_new_entry(new_entry)
  new_entry = 0.0 if new_entry < 0.0
  new_entry = 1.0 if new_entry > 1.0
  new_entry
end

# Determine's how much of a speed adjustment to return
def return_speed_adjustment(speed)
  1 + (speed.to_f - NORMAL_SPEED) / NORMAL_SPEED
end

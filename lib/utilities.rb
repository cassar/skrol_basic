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

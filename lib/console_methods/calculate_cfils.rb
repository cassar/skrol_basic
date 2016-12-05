# Calculates the Character Frequency Inter Language Scores (CFILS) for all
# characters under a base_script mapped to target_script.
# Will also remove all old CFILS scores before applying new values.
def calculate_cfils(base_script, target_script)
  return unless check_all_chars(base_script, target_script)
  clear_old_cfils_scores(base_script, target_script)
  target_chars_total = calculate_total_chars(target_script)
  assign_cfils_scores(base_script, target_script, target_chars_total)
end

# Assigns a CFILS score to all character records of a base_script mapped to a
# target_script.
def assign_cfils_scores(base_script, target_script, target_chars_total)
  base_catalogue = derive_chars_catalogue(base_script)
  target_catalogue = derive_chars_catalogue(target_script)
  base_catalogue.each do |key, _value|
    char = base_script.characters.where(entry: key).first
    raise Invalid, "No Char record '#{key}' found" if char.nil?
    score = 0
    target_value = target_catalogue[key]
    score = target_value.to_f / target_chars_total unless target_value.nil?
    char.scores.create(map_to_id: target_script.id, map_to_type: 'scripts',
                       score_name: 'CFILS', score: score)
  end
end

# Removes all existing CFILS scores mapped from all all char records in a
# particular script to another script.
def clear_old_cfils_scores(base_script, target_script)
  base_script.characters.each do |char|
    char.scores.where(map_to_id: target_script.id, map_to_type: 'scripts',
                      score_name: 'CFILS').each(&:destroy)
  end
end

# Calculates the total chracter count in a library of words under a script
def calculate_total_chars(script)
  total = 0
  script.words.each do |word|
    total += word.entry.length
  end
  total
end

# Checks that both scripts have at least one character record.
def check_all_chars(base_script, target_script)
  if !check_avail_chars(base_script) || !check_avail_chars(target_script)
    raise Invalid, 'No base or no target words.'
  end
  true
end

# Returns true if a given script has more that one character record.
def check_avail_chars(script)
  return true if script.characters.count > 0
  false
end

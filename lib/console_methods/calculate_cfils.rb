# Calculates the Character Frequency Inter Language Scores (CFILS) for all
# characters used by a particular script in a particular language storing
# results in the scores table.
def calculate_cfils(base_code, script, target_code)
  return unless check_all_chars(base_code, target_code, script)
  clear_old_cfils_scores(base_code, script, target_code)
  target_chars_total = calculate_total_chars(target_code, script)
  assign_cfils_scores(base_code, script, target_code, target_chars_total)
end

# Assigns a CFILS score to all character records given a base_code, script,
# target_code, and target_chars_total in the target language.
def assign_cfils_scores(base_code, script, target_code, target_chars_total)
  base_catalogue = derive_chars_catalogue(base_code, script)
  target_catalogue = derive_chars_catalogue(target_code, script)
  base_catalogue.each do |key, _value|
    char = Character.where(entry: key).first
    score = 0
    unless target_catalogue[key].nil?
      score = target_catalogue[key].to_f / target_chars_total
    end
    char.scores.create(map_to: target_code, score_name: 'CFILS', score: score)
  end
end

# Removes all existing CFILS scores associated with a particular base_code
# and script, and mapped to particular target_code.
def clear_old_cfils_scores(base_code, script, target_code)
  Character.where(language: base_code, script: script).each do |char|
    char.scores.where(map_to: target_code, score_name: 'CFILS').each(&:destroy)
  end
end

# Calculates the total chracter count in a library of words under a particular
# script, either 'base' or 'phonetic'
def calculate_total_chars(lang_code, script)
  total = 0
  Word.where(language: lang_code).each do |word|
    total += word[script].length
  end
  total
end

# Checks that both a base_code and a target_code records in the Charcters
# table under a particular script.
def check_all_chars(base_code, target_code, script)
  if !check_avail_chars(base_code, script)
    puts 'no base_chars'
    return false
  elsif !check_avail_chars(target_code, script)
    puts 'no target_chars'
    return false
  end
  true
end

# Returns true if a given lang_code and script has more that one record under
# characters.
def check_avail_chars(lang_code, script)
  return true if Character.where(language: lang_code, script: script).count > 0
  false
end

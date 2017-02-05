# Calculates and creates new WCFBS score given a target_word record and a
# base_script
def compile_wcfbs(target_word, base_script)
  score = calculate_wcfbs(target_word, base_script)
  target_word.scores.where(map_to_id: base_script.id, map_to_type: 'Script',
                           name: 'WCFBS').destroy_all
  target_word.scores.create(map_to_id: base_script.id, map_to_type: 'Script',
                            name: 'WCFBS', entry: score)
end

# Calculates the Word Characters Frequency Target Scores (WCFBS) for a
# particular entry.
def calculate_wcfbs(target_word, base_script)
  scores_sum = 0.0
  return scores_sum if target_word.nil?
  char_arr = target_word.entry.scan(/./)
  char_arr.each do |entry|
    scores_sum += return_cfils_score(entry, base_script)
  end
  scores_sum / target_word.entry.length
end

# Retrieves a CFILS score for a particular char entry and script mapped to a
# particular base_script.
# This is the CFS of the charcter in a target script.
def return_cfils_score(char_entry, base_script)
  char = base_script.characters.where(entry: char_entry).first
  return 0.0 if char.nil?
  cfils_score = char.scores.where(map_to_id: base_script.id,
                                  map_to_type: 'Script',
                                  name: 'CFS').first
  raise Invalid, "No CFS score for '#{char_entry}'!" if cfils_score.nil?
  cfils_score.entry
end

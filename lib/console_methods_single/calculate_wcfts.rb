# Calculates and creates new WCFTS score given a word record and a target_script
def compile_wcfts(word, target_script)
  score = calculate_wcfts(word, target_script)
  word.scores.create(map_to_id: target_script.id, map_to_type: 'scripts',
                     score_name: 'WCFTS', score: score)
end

# Calculates the Word Characters Frequency Target Scores (WCFTS) for a
# particular entry.
def calculate_wcfts(word, target_script)
  scores_sum = 0.0
  char_arr = word.entry.scan(/./)
  char_arr.each do |entry|
    scores_sum += return_cfils_score(entry, target_script)
  end
  scores_sum / word.entry.length
end

# Retrieves a CFILS score for a particular char entry and script mapped to a
# particular target_script.
# This is the CFS of the charcter in a target script.
def return_cfils_score(char_entry, target_script)
  char = target_script.characters.where(entry: char_entry).first
  return 0.0 if char.nil?
  cfils_score = char.scores.where(map_to_id: target_script.id,
                                  map_to_type: 'scripts',
                                  score_name: 'CFS').first
  raise Invalid, "No CFS score for '#{char_entry}'!" if cfils_score.nil?
  cfils_score.score
end

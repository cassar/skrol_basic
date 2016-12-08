# Calculates and creates a new WCFBS score for a given word record.
def compile_wcfbs(word)
  script = word.script
  score = calculate_wcfbs(word)
  word.scores.create(map_to_id: script.id, map_to_type: 'scripts',
                     score_name: 'WCFBS', score: score)
end

# Calculates the Word Characters Frequency Base Scores (WCFBS) for a
# particular word record.
def calculate_wcfbs(word)
  scores_sum = 0.0
  char_arr = word.entry.scan(/./)
  script = word.script
  char_arr.each { |entry| scores_sum += return_cfs_score(entry, script) }
  score = scores_sum / word.entry.length
end

# Retrieves a CFS score for a particular char entry and script mapped to a
# particular target_script.
def return_cfs_score(char_entry, script)
  char = script.characters.where(entry: char_entry).first
  raise Invalid, "No chars matching '#{char_entry}'!" if char.nil?
  cfs_score = char.scores.where(score_name: 'CFS').first
  raise Invalid, "No CFS score for '#{char_entry}'!" if cfs_score.nil?
  cfs_score.score
end

# Calculates and creates a new WCFTS score for a given word record.
def compile_wcfts(target_word)
  target_script = target_word.script
  score = calculate_wcfts(target_word)
  target_word.scores.create(map_to_id: target_script.id, map_to_type: 'scripts',
                            name: 'WCFTS', entry: score)
end

# Calculates the Word Characters Frequency Base Scores (WCFTS) for a
# particular word record.
def calculate_wcfts(target_word)
  scores_sum = 0.0
  char_arr = target_word.entry.scan(/./)
  target_script = target_word.script
  char_arr.each { |entry| scores_sum += return_cfs_score(entry, target_script) }
  score = scores_sum / target_word.entry.length
end

# Retrieves a CFS score for a particular char entry and script mapped to a
# particular target_script.
def return_cfs_score(char_entry, target_script)
  char = target_script.characters.where(entry: char_entry).first
  raise Invalid, "No chars matching '#{char_entry}'!" if char.nil?
  cfs_score = char.scores.where(name: 'CFS').first
  raise Invalid, "No CFS score for '#{char_entry}'!" if cfs_score.nil?
  cfs_score.entry
end

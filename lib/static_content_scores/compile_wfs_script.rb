# Calculates and stores all the Word Frequency Score (WFS) for a particular
# script.
def compile_wfs_script(script)
  raise Invalid, 'No words attached to script!' if script.words.count < 1
  Score.where(name: 'WFS', map_to_id: script.id,
              map_to_type: 'Script').destroy_all
  catalogue = derive_words_catalogue(script)
  total_words = return_word_total(catalogue)
  assign_wfs(script, catalogue, total_words)
end

# Returns the total of all values in an object called catalogue
def return_word_total(catalogue)
  total = 0
  catalogue.each do |_key, value|
    total += value
  end
  total
end

# Creates new WFS score record for all matching word records belonging to a
# script
def assign_wfs(script, catalogue, total_words)
  script.words.each do |word|
    numerator = catalogue[word.entry]
    numerator = 0 if numerator.nil?
    score = numerator.to_f / total_words
    word.create_update_score('WFS', script, score)
  end
end

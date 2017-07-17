# Calculates and stores all the Word Frequency Score (WFS) for a particular
# script.
def compile_wfs_script(script, word_scores_obj)
  raise Invalid, 'No words attached to script!' if script.words.count < 1
  catalogue = derive_words_catalogue(script)
  total_words = return_word_total(catalogue)
  assign_wfs(script, catalogue, total_words, word_scores_obj)
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
def assign_wfs(script, catalogue, total_words, word_scores_obj)
  script.words.each do |word|
    numerator = catalogue[word.entry]
    numerator = 0 if numerator.nil?
    score = numerator.to_f / total_words
    # word.scores.create(map_to_id: script.id, map_to_type: 'Script', name: 'WFS',
    #                    entry: score)
    word_scores_obj[word.id]['WFS'] = score
  end
end

# Computes the Character Frequency Scores (CFS) for all characters used in an
# array of words returning an object of the form...
# {char => CFS}
def compile_chars_cfs(words)
  catalogue = derive_chars_catalogue(words)
  total = return_total_char_count(catalogue)
  return_cfs_scores(catalogue, total)
end

# Will return total character count in sample catalogue for use in
# Character frequency score (CFS) computation.
def return_total_char_count(catalogue)
  total = 0
  catalogue.each_value { |value| total += value }
  total
end

# Takes a char count catalogue and the total number of characters to compute a
# CFS for each character and return it in an object of the form...
# {char => CFS}
def return_cfs_scores(catalogue, total)
  char_score_obj = {}
  catalogue.each { |char, count| char_score_obj[char] = count.to_f / total }
  char_score_obj
end

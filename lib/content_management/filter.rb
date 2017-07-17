# Will return false if a word is not deamed suitable to be shown to a user.
# true otherwise.
def word_good?(word)
  return false if word.phonetic.nil?
  return false if word.phonetic.entry == NONE
  true
end

# Will return false if a sentence is not deemed suitable to be shown to a usere
# true otherwise.
def sent_good?(sentence)
  return false if sentence.entry.length > 40
  return false if sentence.phonetic.nil?
  return false if sentence.phonetic.entry.include? NONE
  true
end

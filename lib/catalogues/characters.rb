# Takes an array of words and returns a catalogue object with all the characters
# used in the word records of that script along with its corresponding count.
# {char => char_count}
def derive_chars_catalogue(words)
  catalogue = {}
  words.each { |word| add_chars_to_catalogue(word, catalogue) }
  catalogue
end

# Takes a word entry which gets broken up into constituent characters.
# Chars are then added to catalogue object or incremented if they already exist.
def add_chars_to_catalogue(word, catalogue)
  word.entry.scan(/./).each do |char|
    catalogue[char] = 0 if catalogue[char].nil?
    catalogue[char] += 1
  end
end

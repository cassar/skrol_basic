# Takes a script record and return a catalogue object with all the characters
# used in the word records of that script along with its corresponding count.
def derive_chars_catalogue(script)
  catalogue = {}
  script.words.each { |word| add_chars_to_catalogue(word, catalogue) }
  catalogue
end

# Adds chars to catalogue object, increments existing entry by 1 if already
# present.
def add_chars_to_catalogue(word, catalogue)
  char_arr = word.entry.scan(/./)
  char_arr.each do |char|
    if catalogue[char].nil?
      catalogue[char] = 1
    else
      catalogue[char] += 1
    end
  end
end

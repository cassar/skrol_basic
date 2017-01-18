# Returns a language record given a name
def lang_by_name(name)
  lang = Language.where(name: name).first
  raise Invalid, "No language with #{name} found!" if lang.nil?
  lang
end

# Returns a User record given a name
def user_by_name(name)
  user = User.where(name: name).first
  raise Invalid, "No user with #{name} found!" if user.nil?
  user
end

# Returns a Language record given an id
def lang_by_id(id)
  lang = Language.where(id: id).first
  raise Invalid, "No language with id: #{id} found!" if lang.nil?
  lang
end

# Returns a Word record given an an id
def word_by_id(id)
  word = Word.where(id: id).first
  raise Invalid, "No word with id: #{id} found!" if word.nil?
  word
end

# Returns a Sentence record given an id
def sentence_by_id(id)
  sent = Sentence.where(id: id).first
  raise Invalid, "No sentence with id: #{id} found!" if sent.nil?
  sent
end

def retrieve_char(entry, script)
  char = script.characters.where(entry: entry).first
  raise Invalid, "No char: '#{entry}' for that script on record!" if char.nil?
  char
end

# Returns word record associated with an entry.
# Will search for capitalized version if it can't find first version.
# Same as retrieve_word in calculate_swos
def return_word(entry, script)
  word = script.words.where(entry: entry).first
  word = script.words.where(entry: entry.downcase).first if word.nil?
  word = script.words.where(entry: entry.capitalize).first if word.nil?
  word
end

# Retrieves the english group id of a foreign word if available.
def retrieve_english_id(base_entry, base_script)
  english = lang_by_name('English').base_script
  english_entry =
    base_entry.translate(base_script.lang_code, english.lang_code)
  english_word = return_word(english_entry, english)
  return english_word.group_id unless english_word.nil?
  nil
end

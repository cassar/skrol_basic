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

# Returns a Word Record given a user may and a rank_num
# Note rank_num is entered seperately so difference ranks can be checked
# without having to update the DB.
def word_by_rank(user_map, word_rank)
  rank = Rank.where(entry: word_rank, entriable_type: 'Word',
                    lang_map_id: user_map.lang_map.id).first
  raise Invalid, "Rank with word_rank: #{word_rank} not found" if rank.nil?
  word = rank.entriable
  raise Invalid, "word_id: #{rank.word_id} not found" if word.nil?
  word
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
  script.words.where(entry: entry.downcase).first
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

# Returns a list of Work Rank records mapped to a partular lang_map.
def retrieve_word_ranks(lang_map)
  Rank.where(entriable_type: 'Word', lang_map_id: lang_map.id)
end

# Returns an STS given a sentence ID and a base script.
def retrieve_sts(sentence_id, lang_map)
  score = Score.where(entriable_id: sentence_id, entriable_type: 'Sentence',
                      name: 'STS', map_to_id: lang_map.id,
                      map_to_type: 'LangMap').first
  raise Invalid, "No STS found for sentence_id: #{sentence_id}" if score.nil?
  score
end

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

# Returns a User record given an id
def user_by_id(id)
  user = User.where(id: id).first
  raise Invalid, "No user with id: #{id} found!" if user.nil?
  user
end

# Returns a user_score record given a user_metric record
def user_score_by_metric(metric)
  user = user_by_id(metric.user_id)
  score = user.user_scores.where(target_word_id: metric.target_word_id).first
  raise Invalid, "No score for metric.id: #{metric.id} found" if score.nil?
  score
end

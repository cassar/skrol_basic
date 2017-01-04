# The average percentage of a word's sentences that have been viewed across all
# users.
def average_exhaust(word)
  total_exhaust = 0
  raise Invalid, 'No users! cannot run average_exhaust!' if User.count.zero?
  User.all.each { |user| total_exhaust += user_exhaust(user, word) }
  return 0 if total_exhaust.zero?
  total_exhaust / User.count
end

# Returns the percentage of sentences that have been viewed (exhausted) for a
# given word by a given user.
def user_exhaust(user, word)
  # Retrieve all sentences related to a word.
  sentences = sentences_found_in(word)
  # Retrieve all metrics related to the sentences (could be more than one per)
  metrics = related_metrics(sentences, user)
  # Populate Catalogue
  exhaust_cat = populate_exhaust_catalouge(sentences, metrics)
  # Return Percentage Exhausted (as decimal)
  return_user_exhaust(exhaust_cat)
end

# Returns an array with all metrics related to all sentences in a given
# sentences array related to a given user.
def related_metrics(sentences, user)
  metrics = []
  sentences.each do |sentence|
    user.user_metrics.where(target_sentence_id: sentence.id).each do |metric|
      metrics << metric
    end
  end
  metrics
end

# Returns an exhast catalouge hash which is has as its keys the sentences id's
# provided by a given sentences array and a boolean for its key. True for
# 'is exhausted', false otherwise.
def populate_exhaust_catalouge(sentences, metrics)
  exhaust_cat = {}
  sentences.each { |sentence| exhaust_cat[sentence.id] = false }
  metrics.each do |metric|
    if exhaust_cat.key? metric.target_sentence_id
      exhaust_cat[metric.target_sentence_id] = true
    end
  end
  exhaust_cat
end

# Uses a given exhast catalouge to determine a user_exhaust metric.
def return_user_exhaust(exhaust_cat)
  counter = 0
  exhaust_cat.each { |_key, value| counter += 1 if value }
  counter.to_f / exhaust_cat.count
end

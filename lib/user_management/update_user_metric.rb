# Takes a json object and updates a user_metric with results from the client.
def update_user_metric(obj)
  search_fields = return_search_fields(obj)
  metric = return_user_metric(search_fields)
  metric_results = return_metric_results(obj)
  update_metric(metric, metric_results)
  [metric.apply_user_score, Word.find(metric.target_word_id).entry]
end

# Returns search fields array given a json object.
def return_search_fields(obj)
  user_map = UserMap.where(id: obj['user_map_id'].to_i).first
  target_word_id = obj['word_id'].to_i
  target_sentence_id = return_target_sentence_id(user_map, obj)
  [user_map, target_word_id, target_sentence_id]
end

# Returns a target_sentence_id given a user_map an a json object
def return_target_sentence_id(user_map, obj)
  target_script = user_map.target_script
  group_id = obj['group_id'].to_i
  sent = target_script.sentences.where(group_id: group_id).first
  raise Invalid, "No sentence.group_id: #{group_id} found." if sent.nil?
  sent.id
end

# Returns a UserMetric record given a search field array
def return_user_metric(search_fields)
  user_map, target_word_id, target_sentence_id = search_fields
  metric =
    user_map.user_metrics.where(target_word_id: target_word_id,
                                target_sentence_id: target_sentence_id).first
  metric = create_metric_and_score(search_fields) if metric.nil?
  metric
end

# Creates new user_metric and user_score given search fields
def create_metric_and_score(search_fields)
  user_map, target_word_id, target_sentence_id = search_fields
  user_map.create_touch_score(Word.find(target_word_id))
  user_map.user_metrics.create(target_word_id: target_word_id,
                               target_sentence_id: target_sentence_id)
end

# Returns metric results in an array given a json object
def return_metric_results(obj)
  speed = obj['speed'].to_i
  pause = obj['pause'] == 'true'
  hover = obj['hover'] == 'true'
  hide = obj['hide'] == 'true'
  [speed, pause, hover, hide]
end

# Updates a given metric with given metric result array.
def update_metric(metric, metric_results)
  speed, pause, hover, hide = metric_results
  metric.update(speed: speed, pause: pause, hover: hover, hide: hide)
end

# Returns a new word score entry given the metric and score records
def return_user_word_score(metric, score)
  new_entry = score.entry
  new_entry += NORMAL_BONUS * return_speed_adjustment(metric.speed)
  new_entry -= PAUSE_PENALTY if metric.pause
  new_entry -= HOVER_PENALTY if metric.hover
  new_entry += HIDE_BONUS if metric.hide
  new_entry = fix_new_entry(new_entry)
end

# Makes sure entry floor is 0.0 and ceiling is 1.0
def fix_new_entry(new_entry)
  new_entry = 0.0 if new_entry < 0.0
  new_entry = 1.0 if new_entry > 1.0
  new_entry
end

# Determine's how much of a speed adjustment to return
def return_speed_adjustment(speed)
  1 + (speed.to_f - NORMAL_SPEED) / NORMAL_SPEED
end

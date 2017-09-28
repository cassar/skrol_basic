# Retrieves the max word length mapped to a particular script.
def max_word_length(script)
  max_length = 0
  script.words.each do |word|
    word_length = word.entry.length
    max_length = word_length if max_length < word_length
  end
  max_length
end

# Turns the logger off
def logger_off
  $old_logger = ActiveRecord::Base.logger
  ActiveRecord::Base.logger = nil
end

# Turns the logger on
def logger_on
  ActiveRecord::Base.logger = $old_logger
end

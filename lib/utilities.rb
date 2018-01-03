# Retrieves the max word length in an array of word records
def max_word_length(words)
  max_length = 0
  words.each do |word|
    word_length = word.entry.length
    max_length = word_length if max_length < word_length
  end
  max_length
end

# Turns the logger off
def logger_off
  old_logger = ActiveRecord::Base.logger
  ActiveRecord::Base.logger = nil
  old_logger
end

# Turns the logger on
def logger_on(old_logger)
  ActiveRecord::Base.logger = old_logger
  nil
end

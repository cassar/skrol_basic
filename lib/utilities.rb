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

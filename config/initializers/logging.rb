EVENT_LOG_FILE = File.open(File.join(Rails.root, "log", "#{Rails.env}_event_log.txt"), "a+")

class << Rails
  def event_log
    EVENT_LOG_FILE
  end
end

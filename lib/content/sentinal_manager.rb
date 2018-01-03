module SentinalManager
  def self.retrieve(script)
    sentinal = script.words.find_by entry: NONE
    sentinal = script.words.create(entry: NONE) if sentinal.nil?
    sentinal
  end
end

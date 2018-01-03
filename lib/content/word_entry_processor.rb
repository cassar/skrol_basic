class WordEntryProcessor
  def initialize(script, source, words = nil)
    @script = script
    words = script.words if words.nil?
    @entry_to_word = derive_entry_to_record(words)
    @meta_manager = MetaDataManager.new(source, script.word_meta_data)
    @created_count = 0
  end

  attr_reader :created_count

  def process(word_entry, meta_entry = nil)
    standard_candidate = word_entry.downcase
    word = @entry_to_word[standard_candidate]
    return word unless word.nil?
    word = @script.words.create(entry: standard_candidate)
    return report(standard_candidate) unless word.persisted?
    @entry_to_word[word.entry] = word
    @created_count += 1
    meta_entry = { entry: word_entry } if meta_entry.nil?
    @meta_manager.process(word, meta_entry)
    word
  end

  private

  def report(standard_candidate)
    open('lib/onboard/word_entry_processor_log.out', 'a') do |file|
      file.puts "word_entry: '#{standard_candidate}' did not save"
    end
    nil
  end
end

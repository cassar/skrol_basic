class MetaDataManager
  def initialize(source, current_meta_data)
    @source = source
    @meta_ids = current_meta_data.where(source: source).pluck(:id)
  end

  def process(record, meta_entry)
    return if @meta_ids.include? record.id
    record.meta_data.create(source: @source, entry: meta_entry)
    @meta_ids << record.id
  end
end

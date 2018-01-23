class MetaDataProcessor
  def initialize(meta_data, source, model_name)
    @source = source
    @model_name = model_name
    @record_ids = if %w[WordAssociate SentenceAssociate].include? model_name
                    meta_data.map!(&:contentable_id)
                  else
                    meta_data.where(source: source).pluck(:contentable_id)
                  end
    @errors = "#{model_name} meta data that failed to save for source #{source.name}:\n"
    @created_count = 0
  end

  def process(record)
    return if @record_ids.include? record.id
    meta = record.meta_data.create(source: @source)
    if meta.persisted?
      @record_ids << record.id
      @created_count += 1
    else
      @errors << "#{@model_name}_id: #{record.id}\n"
    end
  end

  def report
    report = "#{@created_count} meta records created"
    report << "for #{@source.name} in #{@model_name} model\n"
    report << @errors
    report << "\n"
  end
end

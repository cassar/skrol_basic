class ContentController < ActionController::API
  # params{ source: , script_a: , script_b: , entries: }
  def word_pairs
    return render json: @msg unless valid_key?
    return render json: @msg unless valid_scripts?
    source = Source.find_or_create_by(name: params[:source])
    wp_processor = WordPairProcessor.new(@script_a, @script_b, source)
    render json: { message: wp_processor.process(params[:entries]) }
  end

  # params{ source: , script_a: , script_b: , entries: }
  def sentence_pairs
    return render json: @msg unless valid_key?
    return render json: @msg unless valid_scripts?
    return render json: @msg unless standard_scripts?
    source = Source.find_or_create_by(name: params[:source])
    sp_processor = SentencePairProcessor.new(@script_a, @script_b, source)
    render json: { message: sp_processor.process(params[:entries]) }
  end

  private

  def valid_key?
    @msg = { message: 'Invalid key.' }
    params[:key] == SKROL_KEY
  end

  def valid_scripts?
    @script_a = Script.find_by_name(name = params['script_a'])
    @msg = { message: "script_a: '#{name}' not found." }
    return false if @script_a.nil?
    @script_b = Script.find_by_name(name = params['script_b'])
    @msg = { message: "script_b: '#{name}' not found." }
    return false if @script_b.nil?
    @msg = { message: 'scripts cannot be the same!' }
    return false if @script_a == @script_b
    true
  end

  def standard_scripts?
    @msg = { message: "script_b: '#{@script_a.name}' not a standard script" }
    return false unless @script_a.standard_id.nil?
    @msg = { message: "script_b: '#{@script_b.name}' not a standard script" }
    return false unless @script_b.standard_id.nil?
    true
  end
end

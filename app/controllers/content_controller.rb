class ContentController < ActionController::API
  def add_words
    return render json: @msg unless valid_key?
    return render json: @msg unless valid_language?
    wp_processor = WordPairProcessor.new(@language, params[:source])
    puts "params_words: #{params[:words]}"
    render json: { message: wp_processor.process(params[:words]) }
  end

  private

  def valid_key?
    @msg = { message: 'Invalid key.' }
    params[:key] == SKROL_KEY
  end

  def valid_language?
    @language = Language.find_by_name(name = params['language'])
    @msg = { message: "Language: '#{name}' not found." }
    @language.present?
  end
end

class ContentController < ActionController::API
  def add_words
    language = Language.find_by_name(name = params['language'])
    if language.nil?
      return render json: { message: "Language: '#{name}' not found." }
    end
    wp_processor = WordPairProcessor.new(language, params[:source])
    render json: { message: wp_processor.process(params['words']) }
  end
end

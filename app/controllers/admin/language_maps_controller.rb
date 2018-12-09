class Admin::LanguageMapsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def index
    @language_maps = LanguageMap.all.preload(:base_language, :target_language)
  end

  def show
    @language_map = LanguageMap.find(params[:id])
    @base_language = @language_map.base_language
    @target_language = @language_map.target_language
    @courses = @language_map.courses.preload(:enrolments, :word_scores, :sentence_scores)
  end
end

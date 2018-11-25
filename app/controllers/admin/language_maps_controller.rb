class Admin::LanguageMapsController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_privileges

  def index
    @language_maps = LanguageMap.all
    @id_languages = {}
    Language.all.each { |l| @id_languages[l.id] = l }
  end

  def show
    @language_map = LanguageMap.find(params[:id])
    @base_language = @language_map.base_language
    @target_language = @language_map.target_language
  end
end

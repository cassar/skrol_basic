class Admin::LanguagesController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def index
    @languages = Language.all
  end

  def show
    @language = Language.find params[:id]
    @language_words_count = @language.words.count
    @language_sentences_count = @language.sentences.count
    @contributors = @language.contributors.preload :user
  end
end

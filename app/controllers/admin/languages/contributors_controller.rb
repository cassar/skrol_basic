class Admin::Languages::ContributorsController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def new
    @language = Language.find(params[:language_id])
    return if params[:term].blank?

    @users = User.search(params[:term]).preload :contributing_languages
  end

  def create
    @language = Language.find params[:language_id]
    @contributor = @language.contributors.create contributor_params
    handle_create
  end

  private

  def contributor_params
    params.require(:contributor).permit :user_id
  end

  def handle_create
    if @contributor.save
      flash[:notice] = 'New contributor added'
      redirect_to admin_language_path @language
    else
      flash[:notice] = @contributor.errors.full_messages.to_sentence
      render :new
    end
  end
end

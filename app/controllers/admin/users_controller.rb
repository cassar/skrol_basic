class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :authorize_user!

  def index
    @users = User.all.order(:id).preload(:enrolments, :user_scores)
  end

  def show
    @user = User.find(params[:id])
    @enrolments = @user.enrolments.preload(:user_scores, :target_language)
  end
end

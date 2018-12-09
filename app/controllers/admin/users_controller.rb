class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_privileges

  def index
    @users = User.all.order(:id).preload(:enrolments, :user_scores)
  end

  def show
    @user = User.find(params[:id])
    @enrolments = @user.enrolments.preload(:user_scores, :target_language)
  end
end

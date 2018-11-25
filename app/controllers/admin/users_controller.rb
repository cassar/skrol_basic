class Admin::UsersController < ApplicationController
  before_action :authenticate_user!
  before_action :check_admin_privileges

  def index
    @users = User.all.order(:id)
  end
end

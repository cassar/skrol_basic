class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end

  # Makes sure a user is an admin before letting them proceed.
  def check_admin_privileges
    return if current_user.admin

    flash[:alert] = 'You must have admin privileges to access this section.'
    redirect_to root_path
  end
end

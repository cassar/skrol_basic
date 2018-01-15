class StaticPagesController < ApplicationController
  def landing; end

  def enter_key
    redirect_to sign_up_path if session[:valid_key_entered]
  end

  def check_key
    key = Key.find_by(entry: params[:entry], used: nil)
    if key.present?
      session[:valid_key_entered] = true
      key.update(used: true)
      flash[:notice] = 'Valid key entered, please sign up.'
      return redirect_to sign_up_path
    end
    flash[:alert] = 'Invalid key entered.'
    redirect_to enter_key_path
  end
end

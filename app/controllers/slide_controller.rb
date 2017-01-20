class SlideController < ApplicationController
  def show
    user = user_by_id(params[:id])
    target_script = lang_by_name('Spanish').base_script
    base_script = lang_by_name('English').base_script
    render json: retrieve_next_slide(user, base_script, target_script)
  end
end

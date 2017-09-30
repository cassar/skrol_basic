class SlideController < ApplicationController
  # Sends a new slide to the client
  def send_slide
    user_map = UserMap.find(params[:user_map_id])
    render json: retrieve_next_slide(user_map)
  end

  # Recieves metrics from the user and returns confirmation
  def recieve_metrics
    new_score, entry = update_user_metric(params)
    render json: { message: "'#{entry}' new score = #{new_score}" }
  end

  # Will reset user metrics and scores and send back confirmation
  def reset_user_session
    user = User.find(params[:user_id])
    user.reset_outstanding
    render json: { message: "User scores and metrics for #{user.name} reset." }
  end

  # Returns lang info for use in client
  def return_lang_info
    user = User.find(params[:user_id])
    render json: { info: lang_info(user), current: user.current_name }
  end
end

class SlideController < ApplicationController
  def show
    user_map = user_by_id(params[:id]).user_maps.first
    render json: retrieve_next_slide(user_map)
  end

  def recieve_metrics
    update_user_metric(params)
    render json: { message: 'metric saved' }
  end
end

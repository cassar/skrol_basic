class SlideController < ApplicationController
  def show
    user_map = user_by_id(params[:id]).user_maps.first
    render json: retrieve_next_slide(user_map)
  end
end

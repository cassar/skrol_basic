class SlideController < ApplicationController
  # Sends a new slide to the client
  def send_slide
    enrolment = Enrolment.find(params[:enrolment_id])
    render json: NextSlideRetriever.retrieve(enrolment)
  end

  # Recieves metrics from the user and returns confirmation
  def recieve_metrics
    new_score, entry = UserMetricProcessor.new(params).process
    render json: { message: "'#{entry}' new score = #{new_score}" }
  end

  # Will reset user metrics and scores and send back confirmation
  def reset_user_session
    current_user.reset_outstanding
    render json: { message: "User scores and metrics for #{current_user.name} reset." }
  end

  # Returns lang info, and user info for use in client
  def return_user_info
    render json: { lang: current_user.lang_info, user: current_user.user_info }
  end

  # Updates the setting for a user
  def update_user_setting
    current_user.student.update_setting(params[:new_setting])
    render json: { message: "User setting updated for #{current_user.name}." }
  end

  # Returns estimated time till completion
  def meter
    enrolment = Enrolment.find(params[:enrolment_id])
    render json: { meter: time_to_completion(enrolment) }
  end

  private

  def time_to_completion(enrolment)
    acquired = enrolment.user_scores.where(entry: ACQUIRY_POINT..Float::INFINITY).count
    exhausted = enrolment.user_scores.where(status: EXHAUSTED).count
    total = enrolment.course.word_scores.count
    total_seconds = (total - acquired - exhausted) * AVG_ACQUIRY_TIME
    format_seconds(total_seconds)
  end

  def format_seconds(total_seconds)
    minutes = (total_seconds / 60) % 60
    hours = total_seconds / (60 * 60)
    format('%02d:%02d', hours, minutes)
  end
end

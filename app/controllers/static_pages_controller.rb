class StaticPagesController < ApplicationController
  def landing; end

  def admin
    @user_count = User.count
    @course_count = Course.count
  end
end

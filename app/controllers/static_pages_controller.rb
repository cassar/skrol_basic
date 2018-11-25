class StaticPagesController < ApplicationController
  def landing; end

  def admin
    check_admin_privileges
    @user_count = User.count
    @course_count = Course.count
  end
end

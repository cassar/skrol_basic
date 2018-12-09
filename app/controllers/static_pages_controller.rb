class StaticPagesController < ApplicationController
  def landing; end

  def admin
    authenticate_user!
    authorize_user!
    @user_count = User.count
    @language_count = Language.count
    @language_map_count = LanguageMap.count
  end
end

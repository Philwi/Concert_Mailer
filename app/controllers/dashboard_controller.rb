class DashboardController < ApplicationController
  before_action :logged_in
  before_action :activated
  def index
  end

  private
  protected

  def logged_in
    redirect_to "/" unless current_user
  end

  def activated
    unless current_user.active
      destroy_user_session
      redirect_to "/not_active"
    end
  end
end

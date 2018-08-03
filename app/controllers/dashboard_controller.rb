class DashboardController < ApplicationController
  before_action :logged_in
  def index
  end

  private
  protected

  def logged_in
    redirect_to "/" unless user_signed_in?
  end
end

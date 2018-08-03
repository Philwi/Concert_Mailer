class LandingPageController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :go_to_dashboard
  layout 'landing_page'
  def index
    @user = User.new
  end

  private
  def user_params
    params.require(:users).permit(:email, :password, :name)
  end

  def go_to_dashboard
    redirect_to(dashboard_path) if current_user
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end



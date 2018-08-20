class LandingPageController < ApplicationController
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :go_to_dashboard
  layout 'landing_page'
  def index
    @user = User.new
  end

  def not_active

  end

  private
  def user_params
    params.require(:users).permit(:email, :password, :name)
  end

  def go_to_dashboard
    if current_user && current_user.active
      redirect_to(dashboard_path)
    end
    if current_user && !current_user.active && request.fullpath != ("/not_active")
       redirect_to "/not_active"
    end
  end

  protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
  end
end



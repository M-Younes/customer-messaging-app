class ApplicationController < ActionController::Base
  before_action :authenticate_user!, :authenticate_admin!
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?



  private

  def authenticate_admin!
  	current_user && current_user.admin?
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:login, :email, :characters, :password, :password_confirmation, :remember_me)}
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:login, :email, :characters, :password, :password_confirmation, :current_password) }
  end

end

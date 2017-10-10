class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :authenticate_user!
  before_action :authorize_admin!
  before_action :configure_permitted_parameters, if: :devise_controller?

  private

  def authorize_admin!
    return true if user_signed_in? && current_user.admin?
    sign_out_and_redirect(current_user) if current_user
    false
  end

  def after_sign_in_path_for(resource)
      users_path
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) { |u| u.permit(:login, :email, :characters, :password, :password_confirmation, :remember_me)}
    devise_parameter_sanitizer.permit(:sign_in) { |u| u.permit(:login, :email, :password, :remember_me)}
    devise_parameter_sanitizer.permit(:account_update) { |u| u.permit(:login, :email, :characters, :password, :password_confirmation, :current_password) }
  end

end

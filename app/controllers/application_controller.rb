class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  helper_method :current_user_can_edit?

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[ email name password password_confirmation ])

    devise_parameter_sanitizer.permit(:account_update, keys: %i[ email name password password_confirmation current_password ])
  end

  def current_user_can_edit?(event)
    user_signed_in? && event.user == current_user
  end
end

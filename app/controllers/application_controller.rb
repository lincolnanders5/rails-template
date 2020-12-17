class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :authenticate_user!

  private

  def after_sign_in_path_for(resource)
    # Warn existing users when they sign in if they are using a password from
    # the PwnedPasswords dataset.
    set_flash_message! :alert, :warn_pwned if resource.respond_to?(:pwned?) && resource.pwned?

    request.env['omniauth.origin'] || stored_location_for(resource) || root_url
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up) do |user_params|
      user_params.permit(:username, :email, :password, :password_confirmation)
    end
  end
end

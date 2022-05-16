class ApplicationController < ActionController::Base
  protect_from_forgery with: :null_session
  before_action :configure_sign_up_params, if: :devise_controller?

  def configure_sign_up_params
    devise_parameter_sanitizer.permit(:sign_up, keys: [:name, :mobile])
  end
end

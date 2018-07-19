class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :configure_permitted_parameters, if: :devise_controller?

protected
  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:family_name,:given_name,:family_name_kana,:given_name_kana,:email,:store_id])
    devise_parameter_sanitizer.permit(:sing_in, keys:[:email])
  end
end

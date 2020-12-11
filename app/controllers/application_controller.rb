class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :phone_number,:contact_email,:contact_location])
end
end

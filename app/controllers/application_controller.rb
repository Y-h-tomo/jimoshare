class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :alert_message

  private

def configure_permitted_parameters
  devise_parameter_sanitizer.permit(:sign_up, keys: [:nickname, :phone_number,:contact_email,:contact_location,:prefecture_id])
end
def alert_message
  flash[:alert] = "このポートフォリオページは現在開発中です。サービス利用はできません。"
end

end

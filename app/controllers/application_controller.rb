class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?
  # before_action :alert_message
  before_action :check_items

  private

  def check_items
    @check_items = []
    @time = Time.now
    check_items = Item.where(user_id: current_user, stock: true)
    check_items.each do |item|
      @check_items << item if item.limit <= @time
    end
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:nickname, :phone_number, :contact_email, :adress, :prefecture_id])
  end

  def alert_message
    flash[:alert] = 'このポートフォリオページは現在開発中です。サービス利用はできません。'
  end
end

class HomesController < ApplicationController
  def index
  end

  def new_guest
    user = User.find_or_create_by!(
      email: 'guest@example.com',
      nickname: 'ゲストユーザー',
      phone_number: '0901234567',
      contact_email: 'guest@example.com',
      contact_location: '東京都千代田区サンプル1234',
      prefecture_id: '2'
    ) do |guest|
      guest.password = SecureRandom.urlsafe_base64
      # guest.confirmed_at = Time.now
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザーとしてログインしました。'
  end
  def new_guest2
    user = User.find_or_create_by!(
      email: 'guest2@example.com',
      nickname: 'ゲストユーザー2',
      phone_number: '0907654321',
      contact_email: 'guest2@example.com',
      contact_location: '東京都千代田区サンプル12345',
      prefecture_id: '3'
    ) do |guest|
      guest.password = SecureRandom.urlsafe_base64
      # guest.confirmed_at = Time.now
    end
    sign_in user
    redirect_to root_path, notice: 'ゲストユーザー2としてログインしました。'
  end
end

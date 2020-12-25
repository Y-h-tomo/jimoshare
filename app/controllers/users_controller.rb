class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!, except: :show

  def index
    items = []
    favorites = Favorite.where(user_id: current_user)
    favorites.each do |favorite|
      items << favorite.item
    end
    @like_users = []
    items.each do |item|
      @like_users << item.user
    end
  end

  def edit
  end

  def update
    @user.update(user_params)
  end

  def show
    @items = Item.where(user_id: current_user, stock: false)
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(
      :nickname,
      :email,
      :phone_number,
      :contact_email,
      :prefecture_id,
      :adress
    )
  end

  def set_user
    @user = current_user
  end
end

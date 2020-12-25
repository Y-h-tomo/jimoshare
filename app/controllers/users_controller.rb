class UsersController < ApplicationController
  before_action :set_user
  before_action :authenticate_user!, except: :show

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
    @user = User.find(params[:id])
  end
end

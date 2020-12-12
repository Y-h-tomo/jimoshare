class UsersController < ApplicationController
before_action :set_user
before_action :authenticate_user!, except: :show

  def edit
  end

  def update
  　@user.update(user_params)
  end

  def show
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
    :contact_location,
    :prefecture_id
  )
end
def set_user
  @user = User.find(params[:id])
end
end

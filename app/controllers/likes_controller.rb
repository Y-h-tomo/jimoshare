class LikesController < ApplicationController
  def create
    like = current_user.likes.build(item_id: params[:item_id])
    like.save
    redirect_to "/items/#{params[:item_id]}"
  end

  def destroy
    current_user.likes.find_by(item_id: params[:item_id]).destroy
    redirect_to "/items/#{params[:item_id]}"
  end
end

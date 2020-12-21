class FavoritesController < ApplicationController

def index
 @favorites = Favorite.where(user_id:current_user)
end

def create
  favorite = current_user.favorites.build(item_id: params[:item_id])
  favorite.save!
  redirect_to "/items/#{params[:item_id]}"
end

def destroy
  current_user.favorites.find_by(item_id: params[:item_id]).destroy
  redirect_to "/items/#{params[:item_id]}"
end

end

class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]

  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def create
    @item = Item.create(item_params)
    if @item.save
      redirect_to items_path
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
  end

  def destroy
    if @item.destroy
      redirect_to items_path
    else
      render :show
    end
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def item_params
    params.require(:item).permit(
      :name,
      :quantity,
      :description,
      :category_id,
      :condition_id,
      :deadline,
      :prefecture_id,
      :price,
      :contact_location,
      :image
    ).merge(user_id: current_user.id)
  end
end

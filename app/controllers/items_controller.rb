class ItemsController < ApplicationController
  before_action :set_item, only: %i[show edit update destroy]
  before_action :search_items, only: %i[index search]

  def index
    @items = Item.all
    set_item_column
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
    @item = Item.update(item_params)
    if @item.save
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    if @item.destroy
      redirect_to items_path
    else
      render :show
    end
  end

  def search
    @results = @p.result.includes(:name)
  end

  private

  def set_item
    @item = Item.find(params[:id])
  end

  def search_items
    @p = Item.ransack(params[:q])
  end
  def set_item_column
    @item_name = Item.select("name").distinct
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

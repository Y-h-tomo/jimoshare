class ItemsController < ApplicationController
  def index
    @items = Item.where(stock: 0).order('created_at DESC')
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
    set_item
    @initial_quantity = @item.quantity
    item_quantity = @item.quantity - @item.tickets.count
    @item.quantity = item_quantity
    @count = if @item.quantity.positive?
               item_quantity
             else
               '完売しました'
             end
  end

  def edit
    set_item
  end

  def update
    set_item
    if @item.update(item_params)
      redirect_to item_path(@item)
    else
      render :edit
    end
  end

  def destroy
    set_item
    if @item.destroy!
      redirect_to items_path
    else
      render :show
    end
  end

  def search
    selection = params[:keyword]
    @items = Item.sort(selection)
  end

  def stock
    @items = Item.where(stock: 1).order('created_at DESC')
  end

  def stock_out
    @item = Item.find(params[:item_id])
    @item.stock = 0
    if @item.save
      redirect_to items_path
    else
      render :stock
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
      :image,
      :stock,
      :limit
    ).merge(user_id: current_user.id)
  end
end

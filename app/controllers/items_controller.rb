class ItemsController < ApplicationController
  # before_action :search_item

  def index
    @q = Item.ransack(params[:q])
    @items = if params[:q].present?
               @q.result(distinct: true).where(stock: 0).order('created_at DESC')
             else
               Item.where(stock: 0).order('created_at DESC')
             end
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
    @item = Item.find(params[:id])
    @count = if @item.tickets.count.positive?
               @item.quantity - @item.tickets.count
             else
               @item.quantity
             end
    @count = '完売しました' unless @count.positive?
    @tickets = Ticket.where(item_id: params[:id])
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
    # @results = @p.result.includes(:category_id)
  end

  def sort
    # selection = params[:keyword]
    # @items = Item.sort(selection)
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

  def receipt
    @receipt_items = Item.where(user_id: current_user, stock: false)
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

  def search_item
    @p = Item.ransack(params[:q]) # 検索オブジェクトを生成
  end

  def set_item_column
    @item_name = Item.select('name').distinct  # 重複なくnameカラムのデータを取り出す
  end
end

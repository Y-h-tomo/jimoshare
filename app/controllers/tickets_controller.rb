class TicketsController < ApplicationController
  def index
    @tickets = Ticket.where(user_id: current_user.id, receipt: 0)
  end

  def new
    set_item
    set_tickets
    item_user_ban
    over_ban
    @ticket = Ticket.new
    @out_tickets = Ticket.where(item_id: @item.id)
  end

  def create
    num = Faker::Number.number(digits: 6)
    ticket = Ticket.create(
      number: num,
      item_id: params[:item_id],
      user_id: current_user.id
    )
    if ticket.save
      redirect_to tickets_path
    else
      render :new
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def receipt
    @items  = Item.where(user_id: current_user.id)
  end

  def confirmation
    @ticket = Ticket.find(params[:item_id])
    @ticket.receipt = 1
    if @ticket.save
      redirect_to root_path
    else
      render :receipt
    end
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def set_tickets
    @tickets = Ticket.where(params[:item_id])
  end

  def item_user_ban
    redirect_to items_path if current_user == @item.user
  end

  def over_ban
    redirect_to items_path if @item.tickets.count >= @item.quantity
  end

  def user_check
    out_user = Ticket.find_by(item_id: params[:item_id])
    redirect_to items_path if current_user == out_user
  end

  def random_number_generator(n)
    ''.tap { |s| n.times { s << rand(0..9).to_s } }
  end
end

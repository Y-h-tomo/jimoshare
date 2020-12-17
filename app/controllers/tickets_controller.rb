class TicketsController < ApplicationController
  before_action :set_item,except: %i[index destroy]
  before_action :set_tickets, except: %i[index destroy]
  before_action :over_ban, except: %i[index destroy]
  before_action :item_user_ban, except: %i[index destroy]

  def index
    @tickets = Ticket.where(user_id: current_user.id)
  end

  def new
    @ticket = Ticket.new
    @tickets = Ticket.where(item_id: @item.id)
  end

  def create
    num = Faker::Number.number(digits: 6)
    @ticket = Ticket.new(
      number: num,
      item_id: params[:item_id],
      user_id: current_user.id
    )
    if @ticket.save
      redirect_to tickets_path
    else
      render :new
    end
  end

  def destroy
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
    redirect_to items_path if @item.tickets.count > @item.quantity
  end
  def user_check
    out_user = Ticket.find_by(item_id: params[:item_id])
    redirect_to items_path if current_user == out_user
  end
  def random_number_generator(n)
    ''.tap { |s| n.times { s << rand(0..9).to_s } }
  end
end

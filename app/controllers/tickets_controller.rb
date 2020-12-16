class TicketsController < ApplicationController
  def index
    @ticket = Ticket.new
  end

  def create
    num = Faker::Number.number(digits: 6)
    @ticket = Ticket.create(
      number: num,
      item_id: params[:item_id],
      user_id: current_user.id
    )
    if @ticket.save
      redirect_to items_path
    else
      render :index
    end
  end

  def destroy
  end

  private

  def set_item
    @item = Item.find(params[:item_id])
  end

  def random_number_generator(n)
    ''.tap { |s| n.times { s << rand(0..9).to_s } }
  end
end

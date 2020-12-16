class TicketsController < ApplicationController


def index
  @ticket = Ticket.new
end

def create
  num = random_number_generator(6)
  @ticket =  Ticket.create(number: num,item_id: params[:item_id])
  if @ticket.save
    redirect_to root_path
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
def ticket_params
  params.merge(item_id: params[:item_id])
end

end

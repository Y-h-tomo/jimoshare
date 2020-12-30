class TicketsController < ApplicationController
  def index
    @tickets = Ticket.where(user_id: current_user.id, receipt: 0)
    @used_tickets = Ticket.where(user_id: current_user.id, receipt: 1)
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
    ticket_check
    if @tickets.count > 4
      redirect_to items_path, alert: 'ユーザーの重複発券は5枚までとなっています。'
    else
      num = Faker::Number.number(digits: 6)
      ticket = Ticket.create(
        number: num,
        item_id: params[:item_id],
        user_id: current_user.id
      )
      if ticket.save
        redirect_to tickets_path, notice: 'チケットを発券しました。'
      else
        redirect_to items_path, alert: 'チケット発券に失敗しました。'
      end
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def confirmation
    @ticket = Ticket.find(params[:item_id])
    @ticket.receipt = 1
    if @ticket.save
      redirect_to items_path, notice: 'チケット受け取りが正常に処理されました。'
    else
      flash[:alert] = '受け取り処理に失敗しました。'
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

  def ticket_check
    @tickets = Ticket.where(item_id: params[:item_id], user_id: current_user)
  end

  def random_number_generator(n)
    ''.tap { |s| n.times { s << rand(0..9).to_s } }
  end
end

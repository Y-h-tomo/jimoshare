class CommentsController < ApplicationController
  def new
    @comments = Comment.where(item_id: params[:item_id])
    @item = Item.find(params[:item_id])
    @comment = Comment.new
  end

  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to new_item_comment_path, notice: 'コメントを投稿しました。'
    else
      redirect_to new_item_comment_path, alert: 'コメント投稿に失敗しました。'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, item_id: params[:item_id])
  end
end

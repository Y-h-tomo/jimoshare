class CommentsController < ApplicationController
  def new
    @comments =Comment.all
    @comment =Comment.new
  end

  def create
    @comment =Comment.new(comment:params[:comment][:text])
  end

end

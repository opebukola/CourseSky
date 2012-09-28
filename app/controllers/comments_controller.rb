class CommentsController < ApplicationController

  before_filter :authenticate_user!
  before_filter :correct_user, only: [:destroy]

  def new
    @comment = Comment.new
  end

  def create
    @comment = current_user.comments.build(params[:comment])
    if @comment.save
      redirect_to :back, notice: "Comment saved!"
    else
      redirect_to :back, notice: "Cannot save comment. Please try again"
    end
  end

  def destroy
    Comment.find(params[:id]).destroy
    redirect_to :back, notice: "Comment deleted"
  end

  private

    def correct_user
      @comment = Comment.find(params[:id])
      unless current_user == @comment.user || current_user.admin
        flash[:error] = 'You cannot perform this action'
        redirect_to :back
      end
    end
end

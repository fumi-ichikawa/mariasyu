class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    if @comment.save
      redirect_to mariage_path(@comment.mariage)
    else
      @mariage = @comment.mariage
      @comments = @mariage.comments
      render 'mariages/show'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, mariage_id: params[:mariage_id])
  end
end

class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    @mariage = @comment.mariage
    @comments = @mariage.comments
    if @comment.save
      redirect_to mariage_path(@comment.mariage)
    end
  end

  def destroy
    @mariage = Mariage.find(params[:mariage_id])
    comment = @mariage.comments.find(params[:id])
    if current_user.id == comment.user.id
      comment.destroy
    redirect_back(fallback_location: root_path)
    else
      render "mariages/show"
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, mariage_id: params[:mariage_id])
  end
end
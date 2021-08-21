class CommentsController < ApplicationController
  def create
    @comment = Comment.create(comment_params)
    @mariage = @comment.mariage
    @comments = @mariage.comments
    if @comment.save
      redirect_to mariage_path(@comment.mariage)
      # ActionCable.server.broadcast 'comment_channel', content: @comment, nickname: @comment.user.nickname,
      #                                                 time: @comment.created_at.strftime('%Y/%m/%d %H:%M:%S'), id: @mariage.id
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:text).merge(user_id: current_user.id, mariage_id: params[:mariage_id])
  end
end

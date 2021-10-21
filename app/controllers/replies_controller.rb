class RepliesController < ApplicationController
  def create
    @comment = Comment.find(params[:comment_id])
    @reply = @comment.replies.build(reply_params)
    @reply.user_id = current_user.id
    if @reply.save
      flash[:success] = "コメントを作成しました"
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end
  
  private
  def reply_params
    params.require(:reply).permit(:reply, :user_id, :comment_id)
  end
  
end

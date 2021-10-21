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
  
  def re_rep
    
    @re_rep = Reply.new(re_params)
    p @re_rep.errors.full_messages
    if @re_rep.save
      flash[:success] = "コメントに返信しました"
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
    p @re_rep.errors.full_messages
  end
  
  private
  def reply_params
    params.require(:reply).permit(:reply, :user_id, :comment_id)
  end
  
  def re_params
    params.require(:reply).permit(:reply, :user_id, :reply_id, :comment_id)
  end
  
end

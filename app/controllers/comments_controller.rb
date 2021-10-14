class CommentsController < ApplicationController
  def create
    p 'comme_start==============='
    @comment = Comment.new(comment_params)
    @comment.post_id = comment.posts.build(comment_params)
    @comment.user_id = current_user.id
    p @comment.errors.full_messages
    if @comment.save
      flash[:success] = "コメント created!"
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
    p @comment.errors.full_messages
    p 'comme_end=============='
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id)
  end
end

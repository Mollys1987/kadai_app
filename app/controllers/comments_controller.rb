class CommentsController < ApplicationController
  def create
    p 'comme_start==============='
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメント created!"
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
    p @comment.errors.full_messages
    p 'comme_end=============='
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(parent_id: params[:parent_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :user_id, :post_id, :parent_id)
  end
end

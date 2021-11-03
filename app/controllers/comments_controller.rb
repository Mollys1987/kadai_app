class CommentsController < ApplicationController
  def create
    p 'comme_start==============='
    @post = Post.find(params[:post_id])
    @comment = @post.comments.build(comment_params)
    @comment.user_id = current_user.id
    if @comment.save
      flash[:success] = "コメントを作成しました"
      redirect_back(fallback_location: root_path)
    else
      redirect_back(fallback_location: root_path)
    end
  end

  def new
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(parent_id: params[:parent_id])
  end

  private
  def comment_params
    params.require(:comment).permit(:content, :post_id, :parent_id)
  end
end

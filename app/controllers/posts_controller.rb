class PostsController < ApplicationController
  before_action :logged_in_user, only: [:new, :create, :index, :show]
  before_action :correct_user,   only: [:update, :destroy]
  
  def new
    @post = Post.new
  end
  
  def create
    @post = current_user.posts.build(post_params)
    if @post.save
      flash[:success] = "Micropost created!"
      redirect_to p_index_path
    else
      render :new
    end
  end
  
  def index
    p 'index============='
    @posts = Post.all
    p 'index_end==========='
  end
  
  def show
    p 'show_start========================='
    @post = Post.find(params[:id])
    @like = Like.new
    @comments = @post.comments
    @comment = Comment.new
    @reply = Reply.new
    p 'end========================='
  end
  
  def edit
    @post = Post.find(params[:id])
  end
  
  def update
    @post = Post.find(params[:id])
    if @post.update_attributes(post_params)
      flash[:success] = "Post updated"
      redirect_to p_show_path
    else
      render :edit
    end
  end
  
  def destroy
    p 'des_start========================='
    @post = Post.find_by(id: params[:id])
    @post.destroy
    flash[:success] = "post deleted"
    redirect_to u_show_path(current_user)
    p 'des_end========================='
  end
  
  def search
    @posts = Post.search(params[:keyword])
    @keyword = params[:keyword]
    render "index"
  end
  
  private
    def post_params
      params.require(:post).permit(:title, :content, :user_id, :picture)
    end
    
    def correct_user
      @post = current_user.posts.find_by(id: params[:id])
      redirect_to root_url if @post.nil?
    end
end

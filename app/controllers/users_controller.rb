class UsersController < ApplicationController
  before_action :logged_in_user, only: [:show, :index]
  before_action :correct_user,   only: [:edit, :update]
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)
    if @user.save
      log_in @user
      flash[:success] = "Welcome to the Sample App!"
      redirect_to p_index_path
    else
      render :new
    end
  end
  
  def show
    p'show============'
    @user = User.find(params[:id])
    p'show_end=========='
  end
  
  def index
    @users = User.all.order(id: :asc)
  end
  
  def edit
    @user = User.find(current_user.id)
  end
  
  def update
    @user = User.find(current_user.id)
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      redirect_to u_show_path(current_user.id)
    else
      render 'edit'
    end
  end
  
  def following
    @user = User.find(current_user.id)
  end
  
  def followers
    @user = User.find(current_user.id)
  end
  
  private
    def user_params
      params.require(:user).permit(:email, :prefucture, :city, :password, :password_confirmation)
    end
    
    def correct_user
      @user = User.find(current_user.id)
      redirect_to(root_url) unless current_user?(@user)
    end
end

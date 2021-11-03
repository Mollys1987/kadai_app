class SearchController < ApplicationController
  # def search
  #   @user = User.find(1)
  #   p 's=============='
  #   if params[:email] or params[:city] or params[:title].present?
  #     @users = User.where('email LIKE ?', "%#{params[:email]}%")
  #     @citys = User.where('city LIKE ?', "%#{params[:city]}%")
  #   p '2====================='
  #     @posts = Post.where('title LIKE ?', "%#{params[:title]}%")
  #   else
  #     @users = User.none
  #     @citys = User.none
  #     @posts = Post.none
  #     flash[:notice] = "一致する結果がありません"
  #   end
  # end
  
  def search
    @users = User.where('email LIKE ?', "%#{params[:email]}%")
    respond_to do |format|
      format.json { render json: {users: @users} }
    end
  end
end

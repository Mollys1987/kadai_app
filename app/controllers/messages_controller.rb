class MessagesController < ApplicationController
  def index
    if current_user.id.to_i == params[:id].to_i
      p'1========='
      @user = User.find_by(id: params[:id])
      p'2=========='
      @message_user_ids = Message.where(to_user_id: @user.id).or(Message.where(user_id: @user.id)).distinct.pluck(:user_id)
      p'3============='
      @message_user_ids.delete(@user.id)
      p'4======================'
      if params[:email].present?
      p'5======================='
      @users = User.where('email LIKE ?', "%#{params[:email]}%")
      p'6============================'
      else
        @users = User.none
      end
    else
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end
  def roomshow
    if current_user.id.to_i == params[:user_id].to_i
      @user = User.find_by(id: params[:user_id])
      @to_user = User.find_by(id: params[:to_user_id])
      @messages = Message.where(user_id: params[:user_id],to_user_id: params[:to_user_id]).order(created_at: :asc)
      @message = Message.new
    else
      flash[:notice] = "権限がありません"
      redirect_to("/")
    end
  end
  
  def create
      @message = Message.new(message_params)
      if @message.save
        flash[:notice] = "メッセージを送信しました！"
        redirect_back(fallback_location: root_path)
      else
        redirect_to("/")
        flash[:alert] = "メッセージを送信できませんでした"
      end
  end
  
  private
    def message_params
      params.require(:message).permit(:content, :user_id, :to_user_id)
    end
  
end
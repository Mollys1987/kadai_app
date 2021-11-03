class MessagesController < ApplicationController
  def sending
    @sender = current_user
    @receiver = User.find_by(id: params[:receiver_id])
    p params
    p '0'
    if params[:message][:room]
      p '1'
      @exist_room = Room.find(params[:message][:room])
      p '2'
      @message = @exist_room.messages.build(message_params)
      p '3'
      @message.sender_id = current_user.id
    else
      p '4'
      @exist_room = room_check(params[:message][:sender_id], params[:message][:receiver_id])
      p '5'
      if !@exist_room
        p '6'
        @room = Room.create(rooms_params)
      end
      p '7'
      @message = Message.new(message_params)
      @message.room_id = @room.id
    end
    p '8'
    if @message.save
      flash[:notice] = "メッセージを送信しました！"
      if @exist_room
        redirect_to exist_room_path(@exist_room.id)
      p '9'
      else
        redirect_to exist_room_path(@room.id)
      end
    else
      p '10'
      flash[:alert] = "メッセージを送信できませんでした"
      render "rooms/chat"
    end
    # if params[:message][:room]
    #   @exist_room = Room.find(params[:message][:room])
    #   @message = @exist_room.messages.build(message_params)
    #   @message.sender_id = session[:sender_id]
    #   p @message
    # else
    #   @exist_room = room_check(params[:message][:sender_id], params[:message][:receiver_id])
    #   if !@exist_room
    #     @room = Room.create(rooms_params)
    #   end
    #   @message = Message.new(message_params)
    #   @message.room_id = @room.id
    # end

    # if @message.save
    #   if @exist_room
    #     redirect_to exist_room_path(@exist_room.id)
    #   else
    #     redirect_to exist_room_path(@room.id)
    #   end
    # else
    #   render "rooms/chat"
    # end
  end
  
   def index
      p'1========='
      @user = User.find_by(id: params[:sender_id])
      p'2=========='
      # 履歴表示その２
      @message_user_ids = Message.where(receiver_id: @user.id).or(Message.where(sender_id: @user.id)).distinct.pluck(:sender_id)
      p'3============='
      @message_user_ids.delete(@user.id)
      p'4============='
      @receivers_id = Message.where(receiver_id: @user.id).or(Message.where(sender_id: @user.id)).distinct.pluck(:receiver_id)
      p'5======================'
      @receivers_id.delete(@user.id)
      p'6======================'
      # 履歴表示その１
      @messages = (Message.where(sender_id: @user.id).distinct).or((Message.where(receiver_id: @user.id)).distinct)
      
      if params[:nickname].present?
      p'7======================='
      @users = User.where('nickname LIKE ?', "%#{params[:nickname]}%")
      p'8============================'
      else
        @users = User.none
      end
   end
  def roomshow
      @user = User.find_by(id: params[:sender_id])
      @to_user = User.find_by(id: params[:receiver_id])
      @messages = Message.where(sender_id: params[:sender_id],receiver_id: params[:receiver_id]).or(Message.where(sender_id: params[:receiver_id],receiver_id: params[:sender_id])).order(created_at: :asc)
      @message = Message.new
  end
  
  def create
    p 'params'
      @message = Message.new(message_params)
    p '1'
    p @message.errors.full_messages
      if @message.save
        flash[:notice] = "メッセージを送信しました！"
        redirect_back(fallback_location: root_path)
    p '2'
      else
        redirect_to("/")
        flash[:alert] = "メッセージを送信できませんでした"
      end
    p @message.errors.full_messages
  end
    
  private
    def message_params
      params.require(:message).permit(:content, :sender_id, :receiver_id, :room_id)
    end
    
    def rooms_params
      params.require(:message).permit(:sender_id, :receiver_id)
    end
end
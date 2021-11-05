class MessagesController < ApplicationController
  def sending
    @sender = current_user
    @receiver = User.find_by(id: params[:receiver_id])
    p params
    p '0=================='
    if params[:message][:room_id]
      p '1=============='
      @exist_room = Room.find_by(id: params[:message][:room_id])
      p @exist_room
      p '2========================'
      @message = @exist_room.messages.build(message_params)
      p '3============'
      p @message
      @message.sender_id = current_user.id
      if @message.sender_id == @exist_room.sender_id
        @message.receiver_id = @exist_room.receiver_id
      else
        @message.receiver_id = @exist_room.sender_id
      end
        
      p @message
    else
      p '4============='
      @exist_room = room_check(params[:message][:sender_id], params[:message][:receiver_id])
      p '5'
      if !@exist_room
        p '6'
        @room = Room.create(rooms_params)
      end
      p '7'
      @message = Message.new(message_params)
      @message.room_id = @room.id
      p @message.errors.full_messages
      p @room.errors.full_messages
    end
    p '8'
    p @message.errors.full_messages
    if @message.save
    p @message.errors.full_messages
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
  end
    
  private
    def message_params
      params.require(:message).permit(:content, :sender_id, :receiver_id, :room_id)
    end
    
    def rooms_params
      params.require(:message).permit(:sender_id, :receiver_id)
    end
end
class RoomsController < ApplicationController
  def index
    if params[:email].present?
      @users = User.where('email LIKE ?', "%#{params[:email]}%")
    else
      @users = User.none
    end
    @user = current_user
    @rooms = Room.where(sender_id: @user.id).or(Room.where(receiver_id: @user.id))
  end
  
  def chat
    @sender = current_user
    p '1==========='
    if params[:receiver_id]
      @receiver = User.find_by(id: params[:receiver_id])
    p '2============'
      @room = room_check(@sender, @receiver)
    end
    if params[:room_id]
    p '3==============='
      @room = Room.find_by(id: params[:room_id])
    end
    if @room
      p "========="
      p @room.id
      p "========="
      @messages = Message.where(room_id: @room.id)
    end
  end
end

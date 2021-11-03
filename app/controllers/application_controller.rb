class ApplicationController < ActionController::Base
  include SessionsHelper
  
  def room_check(sender, receiver)
    exist_room = Room.find_by(sender_id: sender, receiver_id: receiver)
    if !exist_room
      exist_room = Room.find_by(sender_id: receiver, receiver_id: sender)
    end
    return exist_room
  end
  
  private

    # ユーザーのログインを確認する
    def logged_in_user
      unless logged_in?
        flash[:danger] = "Please log in."
        redirect_to root_path
      end
    end
end

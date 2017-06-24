class FriendshipsController < ApplicationController

  def create
    friend = User.find(params[:friend_id])

    if current_user.is_friend?(friend)
      flash[:error] = "Friend already added!"
    else
      @friendship = current_user.friendships.build(:friend_id => params[:friend_id])
      if @friendship.save
        flash[:success] = "Friend added"
        redirect_to users_path
      else
        flash[:error] = "Cannot add fiend"
        redirect_to users_path
      end
    end
  end
end

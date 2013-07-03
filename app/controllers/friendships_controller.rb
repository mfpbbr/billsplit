class FriendshipsController < ApplicationController
  def create
    friend = User.find_by_email(params[:friendship][:friend_email])

    friendship = Friendship.new(:user_id => current_user.id, :friend_id => friend.id) if friend
    
    if friend && friendship.save
      flash[:notice] = "Friendship successfully created."
    else
      flash[:notice] = "No user with that email, or you are already friends."
    end
    
    redirect_to root_url
  end
end

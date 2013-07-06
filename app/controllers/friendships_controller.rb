class FriendshipsController < ApplicationController  
  def create
    friend = User.find_by_email(params[:friendship][:friend_email])
    does_not_exist = Friendship.where(:user_id => current_user.id, :friend_id => friend.id).empty? && Friendship.where(:user_id => friend.id, :friend_id => current_user.id).empty?
    
    if (!does_not_exist)
      flash[:notice] = "You are already friends."
    else

      friendship = Friendship.new(:user_id => current_user.id, :friend_id => friend.id) if friend
    
      if friend && friendship.save
        flash[:notice] = "Friendship successfully created."
      else
        flash[:notice] = "No user with that email, or you are already friends."
      end
    end
    
    redirect_to root_url
  end
end

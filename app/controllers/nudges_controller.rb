class NudgesController < ApplicationController
  def create
    nudge = Nudge.new(:user_id => current_user.id, :friend_id => params[:friend_id].to_i)
    friend = User.find(params[:friend_id])
    if nudge.save!
      flash[:notice] = "Successfully nudged."
    else
      flash[:notice] = "Unable to nudge."
    end
    
    redirect_to friend_url(friend)
  end
  
  def destroy
    nudge = Nudge.find(params[:id])
    
    if nudge.destroy
      render :json => nudge
    end
  end
end

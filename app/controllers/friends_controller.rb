class FriendsController < ApplicationController
  def show
    @user = current_user
    @friend = User.find(params[:id])
    @history = @user.get_payment_history_with(@friend)
    @debt_to_friend = @user.calculate_debt_to(@friend)
    money_total = @debt_to_friend + @user.money_lent + @user.money_borrowed
    @red = (@debt_to_friend.to_f / money_total) * 100
    @yellow = (@user.money_borrowed.to_f / money_total) * 100    
      @green = (@user.money_lent.to_f / money_total) * 100
    
    # render :json => @green
    render :show
  end
end

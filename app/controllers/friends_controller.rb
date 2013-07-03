class FriendsController < ApplicationController
  def show
    @user = current_user
    @friend = User.find(params[:id])
    @history = @user.get_payment_history_with(@friend)
    @debt_to_friend = @user.calculate_debt_to(@friend)
    @bills = Bill.all

    render :show
  end
end

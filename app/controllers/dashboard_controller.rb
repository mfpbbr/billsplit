class DashboardController < ApplicationController
  def dashboard
    @user = current_user
    @friends = current_user.friends
    @inverse_friends = current_user.inverse_friends
  end
end

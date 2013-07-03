class DebtsController < ApplicationController
  def new
    @user = current_user
    @debt = Debt.new
    
    render :payment
  end
  
  def create
    @debt = Debt.new(params[:debt])
    
    # render :json => @debt
    @debt.is_a_payment = true
    @debt.creditor_id = current_user.id
    
    if @debt.save!
      flash[:notice] = "Successful payment."
      redirect_to debt_url(@debt)
    else
      flash[:notice] = "Unable to submit payment."
      render :payment
    end
  end
  
  def show
    @debt = Debt.find(params[:id])
    render :show
  end
end

class DebtsController < ApplicationController
  def new
    @user = current_user
    @debt = Debt.new
    
    render :payment
  end
  
  def create    
    # params[:debt].each do |attrs|
    #   debt = Debt.new(attrs)
    #   debt.is_a_payment = true
    #   debt.creditor_id = current_user.id
    #   debt.save!
    # end
    # 
    # flash[:notice] = "#{params[:debt].length} payments submitted!"
    # 
    # redirect_to bills_url
    
    @debt = Debt.new(params[:debt])
    @debt.is_a_payment = true
    @debt.creditor_id = current_user.id
    @debt.save!
    
    respond_to do |format|
      format.html { render :show }
      format.json { render :json => @debt }
    end
          
    # if @debt.save!
    # 
    #   respond_to do |format|
    #     format.html { render :show }
    #     format.json { render :json => @debt }
    #   end
    # 
    # else
    #   flash[:notice] = "Unable to submit payment."
    #   render :payment
    # end
  end
  
  def show
    @debt = Debt.find(params[:id])
    render :show
  end
end
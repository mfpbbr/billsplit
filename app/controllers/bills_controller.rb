class BillsController < ApplicationController
  def index
    @user = current_user
    @debts = current_user.debts
    @credits = current_user.debts
    @history = current_user.get_history
    
    render :index
  end
  
  def show
    @bill = Bill.find(params[:id])
    render :show
  end
  
  def new
    @bill = Bill.new
    @user = current_user
    render :new
  end
  
  def create
    @bill = Bill.new(:user => current_user, :description => params[:bill][:description], :total_amount => params[:bill][:total_amount])
    bill_id = Bill.last.nil? ? 1: Bill.last.id + 1
    debts_count = Bill.calculate(bill_id, params[:bill][:total_amount].to_i, params[:bill][:guests])

    flash[:notice] = debts_count
    
    if @bill.save!
      redirect_to bill_url(@bill)
    else
      render :new
    end
  end
  
  def edit
  end 
  
  def update
  end

end
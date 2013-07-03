class BillsController < ApplicationController
  def index
    @user = current_user
    @debts = current_user.debts
    @history = current_user.get_history
    
    render :index
  end
  
  def show
    @bill = Bill.find(params[:id])
    
    respond_to do |format|
      format.html { render :show }
      format.json { render :json => @bill.to_json(:include => [:debts, :guests]) }
    end
  end
  
  def new
    @bill = Bill.new
    @user = current_user
    render :new
  end
  
  def create
    bill_id = Bill.last.nil? ? 1: Bill.last.id + 1
    @bill = Bill.new(:id => bill_id, :user => current_user, :description => params[:bill][:description], :total_amount => params[:bill][:total_amount])

    debts_count = Bill.calculate(bill_id, params[:bill][:total_amount].to_i, params[:bill][:guests])

    flash[:notice] = debts_count
    
    if @bill.save!
      redirect_to bill_url(@bill)
    else
      render :new
    end
  end
  
  def edit
    @bill = Bill.find(params[:id])
    @user = current_user
    
    respond_to do |format|
      format.html { render :edit }
      format.json { render :json => @bill.to_json(:include => [:debts, :guests]) }
    end
  end 
  
  def update
    @bill = Bill.find(params[:id])
    @bill.debts.destroy_all
    @bill.guests.destroy_all
    debts_count = Bill.calculate(params[:id], params[:bill][:total_amount].to_i, params[:bill][:guests])
    
    if @bill.update_attributes(:description => params[:bill][:description], :total_amount => params[:bill][:total_amount])
      flash[:notice] = "Bill successfully updated."
      redirect_to bill_url(@bill)
    else
      flash[:notice] = "Unable to edit bill."
      render :edit
    end
  end

end
class BillsController < ApplicationController
  def index
    @user = current_user
    @debts = current_user.debts
    @history = current_user.get_history
    
    respond_to do |format|
      format.html { render :index }
      format.json { render :json => @history.to_json(:include =>{:bill => {:include => :guests} }) }
    end
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
    
    if @bill.save!
      Bill.calculate(bill_id, params[:bill][:total_amount].to_i, params[:bill][:guests])

      flash[:notice] = "Bill successfully created."
      redirect_to bill_url(@bill)
    else
      flash[:notice] = "Unable to create bill."
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
    @user = current_user
    @bill.debts.destroy_all
    @bill.guests.destroy_all
   
    if @bill.update_attributes(:description => params[:bill][:description], :total_amount => params[:bill][:total_amount])
      flash[:notice] = "Bill successfully updated."
      Bill.calculate(params[:id], params[:bill][:total_amount].to_i, params[:bill][:guests])
    
      redirect_to bill_url(@bill)
    else
      flash[:notice] = "Unable to edit bill."
      render :edit
    end
  end

end
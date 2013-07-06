class AddMoneyLentMoneyBorrowedToUser < ActiveRecord::Migration
  def change
    add_column :users, :money_lent, :integer
    add_column :users, :money_borrowed, :integer
  end
end

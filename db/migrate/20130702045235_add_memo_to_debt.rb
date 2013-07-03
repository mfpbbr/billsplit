class AddMemoToDebt < ActiveRecord::Migration
  def change
    add_column :debts, :memo, :string
  end
end

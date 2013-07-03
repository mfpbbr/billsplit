class CreateDebts < ActiveRecord::Migration
  def change
    create_table :debts do |t|
      t.integer :bill_id
      t.integer :debtor_id
      t.integer :creditor_id
      t.integer :amount
      t.boolean :is_a_payment

      t.timestamps
    end
  end
end

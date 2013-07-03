class CreateBills < ActiveRecord::Migration
  def change
    create_table :bills do |t|
      t.integer :user_id
      t.string :description
      t.integer :total_amount

      t.timestamps
    end
  end
end

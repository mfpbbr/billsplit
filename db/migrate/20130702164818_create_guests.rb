class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.integer :user_id
      t.integer :bill_id
      t.integer :amount_paid
      t.integer :amount_should_have_paid

      t.timestamps
    end
  end
end

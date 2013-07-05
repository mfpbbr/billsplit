class CreateNudges < ActiveRecord::Migration
  def change
    create_table :nudges do |t|
      t.integer :user_id
      t.integer :friend_id
      t.boolean :viewed

      t.timestamps
    end
  end
end

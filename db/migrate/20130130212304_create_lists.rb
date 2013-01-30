class CreateLists < ActiveRecord::Migration
  def change
    create_table :lists do |t|
      t.integer :user_id
      t.string :name
      t.string :permalink

      t.timestamps
    end
    add_index :lists, :user_id
    add_index :lists, :permalink
  end
end

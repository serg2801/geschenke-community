class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :description
      t.string :url
      t.decimal :price, :precision => 8, :scale => 2
      t.string :slug
      t.integer :user_id
      t.integer :clicks, :default => 0

      t.timestamps
    end

    add_index :products, :user_id
    add_index :products, :clicks
    add_index :products, :price
    add_index :products, :slug
  end
end

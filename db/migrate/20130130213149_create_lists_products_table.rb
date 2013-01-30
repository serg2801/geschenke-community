class CreateListsProductsTable < ActiveRecord::Migration
  def self.up
    create_table :lists_products, :id => false do |t|
      t.references :list
      t.references :product
    end
    add_index :lists_products, [:list_id, :product_id]
    add_index :lists_products, [:product_id, :list_id]
  end

  def self.down
    drop_table :lists_products
  end
end
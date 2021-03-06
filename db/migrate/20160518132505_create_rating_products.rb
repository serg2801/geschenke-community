class CreateRatingProducts < ActiveRecord::Migration
  def change
    create_table :rating_products do |t|

      t.integer :product_id
      t.integer :ip_address_id
      t.integer :evaluation, :default => 0
      t.boolean :liked, :default => false

      t.timestamps
    end
  end
end

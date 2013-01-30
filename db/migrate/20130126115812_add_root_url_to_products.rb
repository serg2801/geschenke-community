class AddRootUrlToProducts < ActiveRecord::Migration
  def change
    add_column :products, :root_url, :string
  end
end

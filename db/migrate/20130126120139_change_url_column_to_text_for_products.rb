class ChangeUrlColumnToTextForProducts < ActiveRecord::Migration
  def up
    change_column :products, :url, :text
    change_column :products, :root_url, :text
    change_column :products, :description, :text
  end

  def down
    change_column :products, :url, :string
    change_column :products, :root_url, :string
    change_column :products, :description, :string
  end
end

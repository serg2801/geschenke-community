class AddCriteriaToProducts < ActiveRecord::Migration
  def change
    add_column :products, :criteria, :text
  end
end

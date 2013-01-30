class AddCriteriaToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :criteria, :text
  end
end

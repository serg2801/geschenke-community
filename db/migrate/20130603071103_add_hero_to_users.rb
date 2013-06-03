class AddHeroToUsers < ActiveRecord::Migration
  def change
    add_column :users, :hero, :boolean, :default => false
  end
end

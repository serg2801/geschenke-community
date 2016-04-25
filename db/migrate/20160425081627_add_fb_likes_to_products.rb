class AddFbLikesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :fb_likes, :integer, :default => 0
  end
end

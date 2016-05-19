class ChangeFbLikesFormatInProducts < ActiveRecord::Migration
  def up
    change_column :products, :fb_likes, :float
  end

  def down
    change_column :products, :fb_likes, :integer
  end
end

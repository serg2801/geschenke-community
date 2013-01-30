class Comment < ActiveRecord::Base
  attr_accessible :content, :product_id, :user_id

  validates_presence_of :user, :product, :content
  validates_length_of :content, :minimum => 1, :maximum => 400

  belongs_to :product
  belongs_to :user
end

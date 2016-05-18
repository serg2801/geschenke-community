class RatingProduct < ActiveRecord::Base
  attr_accessible :product_id, :ip_address_id, :liked, :evaluation
end

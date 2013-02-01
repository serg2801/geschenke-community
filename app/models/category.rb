class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id, :slug, :criteria, :description

  serialize :criteria, Hash
end

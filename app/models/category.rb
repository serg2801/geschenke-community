class Category < ActiveRecord::Base
  attr_accessible :name, :parent_id, :slug, :criteria

  serialize :criteria, Hash
end

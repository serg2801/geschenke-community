class Herodata < ActiveRecord::Base
  self.primary_key = "name"

  attr_accessible :name, :value
end

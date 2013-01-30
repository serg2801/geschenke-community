class List < ActiveRecord::Base
  attr_accessible :name, :permalink, :user_id

  belongs_to :user

  before_create :setup_permalink

  has_and_belongs_to_many :products

  private 
  
  def setup_permalink
    size = 15
    charset = %w{ 2 3 4 6 7 9 c d f g h j k m n p q r t v w x y z}
    random = (0...size).map{ charset.to_a[rand(charset.size)] }.join
    self.permalink = random
  end

end

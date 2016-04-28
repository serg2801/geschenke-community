class User < ActiveRecord::Base
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable, :omniauthable

  attr_accessible :email, :password, :password_confirmation, :remember_me
  attr_accessible :provider, :uid
  attr_accessible :name, :points, :image

  has_many :products
  has_many :comments
  has_many :lists

  after_create :setup_list

  def self.find_for_facebook_oauth(auth, signed_in_resource=nil)
    user = User.where(:provider => auth.provider, :uid => auth.uid).first
    unless user

      user = User.create(
          provider: auth.provider,
          uid: auth.uid,
          email: auth.info.email,
          name: auth.info.first_name,
          image: auth.info.image,
          password: Devise.friendly_token[0, 20]
      )
    end
    return user
  end

  private

  def setup_list
    self.lists.create(:name => "Mein Wunschzettel")
  end

end

class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit]

  def index
    @coocie_module = CoocieModule.first
    @coocie = @coocie_module.body
    @users = User.order("points DESC")
    @heroes = User.where("hero IS true")
    @hero1 = Herodata.where(name: 'img1').first
    @hero2 = Herodata.where(name: 'img2').first
    @hero3 = Herodata.where(name: 'img3').first
    @herotext1 = Herodata.where(name: 'text1').first
    @herotext2 = Herodata.where(name: 'text2').first
    @title = "Unsere Geschenkehelden auf GeschenkeHeld.de | Die Geschenke-Community"

    @max_points = User.maximum("points")
    if @max_points == 0
      @max_points = 1
    end
  end

  def show
    @user = User.find(params[:id])
    if @user
      params[:user_id] = @user.id
      @products = Product.search(params)
      @title = "#{@user.name}'s Geschenkideen"
      render 'products/byuser'
    else
      render :text => "Geschenkeheld nicht gefunden :("
    end
  end

  def edit
    @user = current_user
  end

  def signed_up
    @title = "Willkommen als Geschenkeheld auf GeschenkeHeld.de | Die Geschenke-Community"
  end

end

class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit]

  def index
    @users = User.order("points DESC")
    @title = "Unsere Geschenkehelden auf GeschenkeHeld.de | Die Geschenke-Community"
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

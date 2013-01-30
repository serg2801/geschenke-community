class HomeController < ApplicationController
  def index
    #@users = User.limit(18).order("RANDOM()")
    @users = []
    @user = User.first
    18.times { @users << @user }
  end
end

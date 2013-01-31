class UsersController < ApplicationController
  before_filter :authenticate_user!, :only => [:edit]

  def index
    @users = User.order("points DESC")
  end

  def edit
    @user = current_user
  end

end

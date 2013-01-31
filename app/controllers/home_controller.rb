# encoding: utf-8

class HomeController < ApplicationController
  def index
    @users = User.order("RANDOM()").limit(18)
    @title = "Werde auch ein Geschenkeheld auf GeschenkeHeld.de | Die Geschenke-Community"
  end
end

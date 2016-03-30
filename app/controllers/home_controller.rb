# encoding: utf-8

class HomeController < ApplicationController
  def index
    @coocie_module = CoocieModule.first
    @coocie = @coocie_module.body
    @users = User.order("RANDOM()").limit(18)
    @title = "Werde auch ein Geschenkeheld auf GeschenkeHeld.de | Die Geschenke-Community"
    params[:sort] = "neuste-zuerst"
    params[:per_page] = 50
    @products = Product.search(params)
  end

  def imprint
    @title = "Impressum"
  end

  def sitemap
    @categories = Category.all
    @products = Product.order("created_at DESC").all
    respond_to do |format|
      # format.html # index.html.erb
      format.xml  { render :xml => @sites}
    end
  end

end

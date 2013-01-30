# encoding: utf-8

require 'nokogiri'
require 'open-uri'
require 'uri'

class ProductsController < ApplicationController

  def index
    if params["utf8"] && params[:query] == nil
      vars = {}
      if params[:sort] && params[:sort] != ""
        vars[:sort] = params[:sort]
      end
      if params[:price] && params[:price] != ""
        vars[:price] = params[:price]
      end
      redirect_to recent_products_path(vars)
    end

    @page = params[:seite].to_i || 1

    if params[:slug] == "neue-geschenkideen"
      @title = "Neue Geschenkideen"
      @products = Product.search(params)
    else
      @category = Category.find_by_slug(params[:slug])
      if @category
        @products = Product.search(params, @category.criteria)
        @title = @category.name
      else
        @products = Product.search(params)
        if params[:query]
          @title = "Suche nach #{params[:query]}"
        else
          @title = "Geschenkideen"
        end
      end      
    end    
  end

  def new
    @product = Product.new
  end

  def edit
    @product = current_user.products.find_by_slug(params[:slug])
  end

  def show
    @product = Product.find_by_slug(params[:slug])
    @title = "#{@product.name} auf GeschenkeHeld.de | Die Geschenke-Community"
  end

  def own    
    @user = current_user
    @products = @user.products
    @title = "#{@products.size} eigene Geschenkideen auf GeschenkeHeld.de"
    render 'byuser'
  end

  def update
    @product = current_user.products.find(params[:id])
    @product.name = params[:product][:name]
    @product.description = params[:product][:description]
    @product.price = params[:product][:price]
    @product.criteria = params[:product][:criteria]
    # @product.root_url = URI.parse(URI.encode(@product.url)).host
    if @product.save
      flash[:notice] = 'Geschenkidee wurde aktualisiert!'
      redirect_to :action => 'show', :slug => @product.slug
    else
      render :action => 'edit'
    end
  end

  def create
    @product = current_user.products.new(params[:product])
    @product.price = params[:product][:price].gsub(",",".")
    @product.root_url = URI.parse(URI.encode(@product.url)).host
    if @product.save
      current_user.points += 25
      current_user.save
      redirect_to product_path(@product.slug)
    else
      render :new
    end
  end

  def delete
    @product = current_user.products.find_by_slug(params[:slug])
    if @product
      @product.delete
    end
    redirect_to own_products_path
  end

  def find_images
    url = params[:url]
    doc = Nokogiri::HTML(open(url))
    @results = []
    doc.xpath("//img/@src").each do |src|
      @results.push(make_absolute(src,url))
    end
  end

  def add_comment
    @product = Product.find_by_slug(params[:slug])
    if @product
      @comment = @product.comments.new
      @comment.user = current_user
      @comment.content = params[:content]
      if @comment.save
        current_user.points += 5
        current_user.save
        flash[:notice] = "Kommentar erfolgreich hinzugefügt!"
      end
    end
    redirect_to :back
  end

  private 

  def make_absolute(href, root)
    begin
      return URI.parse(URI.encode(root)).merge(URI.parse(href)).to_s
    rescue
      return nil
    end
  end

end

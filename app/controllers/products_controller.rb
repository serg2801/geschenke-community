# encoding: utf-8
require 'koala'
require 'nokogiri'
require 'open-uri'
require 'uri'

class ProductsController < ApplicationController

  before_filter :authenticate_user!, :only => [:own, :new, :edit, :update, :create, :delete, :add_comment]

  def index
    @coocie_module = CoocieModule.first
    @coocie = @coocie_module.body
    if params["utf8"] && params[:query] == nil
      vars = {}
      vars[:slug] = params[:slug]
      if params[:sort] && params[:sort] != ""
        vars[:sort] = params[:sort]
      end
      if params[:price] && params[:price] != ""
        vars[:price] = params[:price]
      end
      redirect_to product_category_path(vars)
    end

    if params[:slug] == "neue-geschenkideen"
      @category = "1"
      @title = "Neue Geschenkideen auf GeschenkeHeld.de | Die Geschenke-Community"
      @h2 = "Die neusten Geschenkideen"
      if params[:sort] == nil
        params[:sort] = "neuste-zuerst"
      end
      @products = Product.search(params)
    else
      @category = Category.find_by_slug(params[:slug])
      if @category
        @products = Product.search(params, @category.criteria)
        @title = @category.name
        @description = @category.description
      else
        @products = Product.search(params)
        if params[:query]
          @title = "Suche nach #{params[:query]}"
        else
          @title = "Geschenkideen"
        end
      end
    end

    # legacy check
    if @category.nil?
      @legacy = LegacyLink.find_by_slug(params[:slug])
      if @legacy
        redirect_to @legacy.new_url, :status => 301
      else
        render :file => "#{Rails.root}/public/404.html", :layout => false, :status => 404
      end
    end
  end

  def search
    @products = Product.search(params)
    @title = "Suche nach #{params[:query]}"
    render "products/index"
  end

  def new
    @product = Product.new
    @title = "Neue Geschenkidee"
  end

  def edit
    @product = current_user.products.find_by_slug(params[:slug])
    @title = "#{@product.name} bearbeiten"
  end

  def show
    @product = Product.find_by_slug(params[:slug])
    if @product
      @title = "#{@product.name} auf GeschenkeHeld.de | Die Geschenke-Community"
    else
      redirect_to '/neue-geschenkideen'
    end
  end

  def own
    @user = current_user
    params[:ids] = @user.products.map(&:id) # TO-DO: Let ES look for user_id
    params[:sort] = "neuste-zuerst" if params[:sort].nil?
    @products = Product.search(params)
    @title = "#{@products.total} eigene Geschenkideen auf GeschenkeHeld.de"
    render 'byuser'
  end

  def update
    @product = current_user.products.find(params[:id])
    @product.name = params[:product][:name]
    @product.description = params[:product][:description]
    @product.price = params[:product][:price]
    @product.criteria = params[:product][:criteria]
    @product.root_url = URI.parse(URI.encode(@product.url)).host
    if @product.save
      flash[:notice] = 'Geschenkidee wurde aktualisiert!'
      redirect_to :action => 'show', :slug => @product.slug
    else
      render :action => 'edit'
    end
  end

  def create
    @product = current_user.products.new(params[:product])
    @product.price = params[:product][:price].gsub(",", ".")
    @product.root_url = URI.parse(URI.encode(@product.url)).host
    if @product.save
      current_user.points += 5
      current_user.save
      redirect_to product_path(@product.slug)
    else
      render :new
    end
  end

  def delete
    @product = current_user.products.find_by_slug(params[:slug])
    if @product
      @product.destroy
    end
    redirect_to own_products_path
  end

  def find_images
    url = params[:url]
    if params[:url]
      doc = Nokogiri::HTML(open(url).read)
      @results = []
      doc.xpath("//img/@src").each do |src|
        @results.push(make_absolute(src, url))
      end
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

  def track_click
    @product = Product.find_by_slug(params[:slug])
    if @product
      if session["product-#{@product.id}"].nil?
        @product.user.update_attribute(:points, @product.user.points + 1)
        session["product-#{@product.id}"] = true
      end
    end
    render :json => "OK"
  end

  # def likes_count
  #   product = Product.find(params[:product_id])
  #   if !current_user.nil?
  #     @facebook ||= Koala::Facebook::API.new(session["devise.facebook_data"].credentials.token)
  #     block_given? ? yield(@facebook) : @facebook
  #     shares = @facebook.get_object('', id: 'http://www.geschenkeheld.de' + "#{product_path(product.slug)}")["shares"]
  #     puts shares
  #     if product.fb_likes != shares
  #       product.fb_likes = shares
  #       product.save
  #     end
  #     redirect_to :back
  #   else
  #     redirect_to :back
  #   end
  # rescue Koala::Facebook::APIError
  #   logger.info
  #   nil
  # end

  def count_likes
    product = Product.find(params[:product_id])
    ip_address = IpAddress.find_by_ip(request.remote_ip)
    @rating_product = RatingProduct.where(product_id: params[:product_id], ip_address_id: ip_address.id, liked: true)
    if @rating_product === []
      @rating_product = RatingProduct.new(product_id: params[:product_id], evaluation: params[:evaluation], ip_address_id: ip_address.id, liked: true)
      if @rating_product.save
        save_product_likes(params[:product_id])
        product = Product.find(params[:product_id])
        render json: {likes: product.fb_likes}
      end
    else
      # id_rating_product = @rating_product[0].id
      # @rating_product = RatingProduct.find(id_rating_product)
      # @rating = @rating_product.update_attributes(evaluation: params[:evaluation])
      # save_product_likes(params[:product_id])
      # product = Product.find(params[:product_id])

      render json: {flag: false}
    end
  end

  private

  def save_product_likes(product_id)
    @count_evaluation = 0.0
    product = Product.find(product_id)
    @rating_product = RatingProduct.where(product_id: product_id)
    @count_rating_product = @rating_product.count
    @rating_product.each do |i|
      @count_evaluation = @count_evaluation + i.evaluation
    end
    like = @count_evaluation/@count_rating_product
    product.fb_likes = like
    product.save
  end

  def make_absolute(href, root)
    begin
      return URI.parse(URI.encode(root)).merge(URI.parse(href)).to_s
    rescue
      return nil
    end
  end

end

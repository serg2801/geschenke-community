class ListsController < ApplicationController

  before_filter :authenticate_user!, :only => [:index]

  def index
    @coocie_module = CoocieModule.first
    @coocie = @coocie_module.body
    @lists = current_user.lists.order("created_at ASC")
    if params[:permalink] 
      @list = @lists.find_by_permalink(params[:permalink])
    else
      @list = @lists.first
    end
    if @list.nil?      
      @list = current_user.lists.create(:name => "Mein Wunschzettel")
    end
    @title = "#{@list.name} auf GeschenkeHeld.de | Die Geschenke-Community"
    @h2 = @list.name
    params[:ids] = @list.products.map(&:id)
    begin
      @products = Product.search(params)
    rescue
      @products = nil
    end
    render "products/index"
  end

  def show
    @list = List.find_by_permalink(params[:permalink])
    if current_user
      @lists = current_user.lists.order("created_at ASC")
    end
    @title = "#{@list.name} auf GeschenkeHeld.de | Die Geschenke-Community"
    @h2 = @list.name
    params[:ids] = @list.products.map(&:id)
    @products = Product.search(params)
    render "products/index"
  end

  def add_product_to_list
    @list = current_user.lists.find(params[:list_id])
    @product = Product.find(params[:product_id])
    if @list && @product
      begin
        @list.products << @product unless @list.products.include?(@product)
      rescue

      end
    end
  end

  def create
    if current_user
      @list = current_user.lists.create(:name => params[:list_name])
      redirect_to list_path(@list.permalink)
    end
  end

end

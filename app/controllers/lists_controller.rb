class ListsController < ApplicationController

  before_filter :authenticate_user!, :only => [:index]

  def index
    @list = current_user.lists.first
    @title = @list.name
    params[:ids] = @list.products.map(&:id)
    begin
      @products = Product.search(params)
    rescue
      @products = []
    end
    render "products/index"
  end

  def show
    @list = List.find_by_slug(params[:permalink])
    @title = @list.name
    @products = @list.products
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

end

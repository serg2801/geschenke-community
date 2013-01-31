# encoding: utf-8

class Product < ActiveRecord::Base
  include Tire::Model::Search
  include Tire::Model::Callbacks

  attr_accessible :clicks, :description, :name, :price, :slug, :url, :user_id 
  attr_accessible :image, :remote_image_url, :root_url
  attr_accessible :criteria

  before_create :setup_slug

  validates_uniqueness_of :url, :name, :slug
  validates_presence_of :name, :description, :url, :image, :price, :root_url
  validates_length_of :name, :minimum => 3, :maximum => 70
  validates_length_of :description, :minimum => 3, :maximum => 300

  belongs_to :user
  has_many :comments
  has_and_belongs_to_many :lists

  mount_uploader :image, ImageUploader
  process_in_background :image

  serialize :criteria, Hash

  mapping do
    indexes :id, :type => 'integer'
    indexes :user_image
    indexes :user_name
    indexes :name
    indexes :image
    indexes :description
    indexes :clicks, :type => 'integer'
    indexes :price, :type => 'float'
    indexes :created_at, :type => 'date'
    indexes :updated_at, :type => 'date'
  end

  def to_indexed_json
    to_json(methods: [:user_name, :user_image])
  end

  def user_name
    user.name
  end

  def user_image
    user.image
  end


  def self.search(params, criteria=nil)
    case params[:sort]
    when "preis-aufsteigend"
      sortfield = "price"
      sortorder = "asc"
    when "preis-absteigend"
      sortfield = "price"
      sortorder = "desc"
    when "recent"
      sortfield = "created_at"
      sortorder = "desc"
    else
      sortfield = "clicks"
      sortorder = "desc"
    end

    if params[:price]
      if params[:price].include? "bis"
        operator = "lte"
      else
        operator = "gte"
      end
      price = params[:price].split("-")[1].to_f + 0.01
    end

    tire.search(page: params[:seite], per_page: 12) do
      query { string params[:query], default_operator: "AND" } if params[:query].present?
      unless criteria.nil?
        criteria.each do |name, value|
          filter :term, name.to_sym => "1" unless value == "0"
        end
      end
      filter :ids, :values => params[:ids] unless params[:ids].nil?
      filter :range, :price => {operator.to_sym => price.to_f} unless price.nil?
      sort { by sortfield.to_sym, sortorder }
      # raise to_json
      # raise to_curl
    end

  end

  def price=(price)
    write_attribute(:price, price.gsub(',', '.'))
  end

  private

  def setup_slug
    if self.slug.nil?
      self.slug = self.name.gsub("ä", "ae").gsub("ö", "oe").gsub("ü", "ue").parameterize
    end
  end

end

App::Application.routes.draw do

  match '/impressum' => "home#imprint"
  match '/sitemap' => "home#sitemap"

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  match '/neue-geschenkidee' => 'products#new', :as => :new_product
  match '/geschenk/:slug' => 'products#show', :as => :product, :via => :get
  match '/geschenk/:slug/bearbeiten' => 'products#edit', :as => :edit_product
  match '/geschenk/:slug/neuer-kommentar' => 'products#add_comment', :as => :add_comment_product
  match '/geschenk/:slug/loeschen' => 'products#delete', :as => :delete_product
  resources :products, :path => "geschenk" do   
    collection do
      post 'find_images', :as => :find_images
    end
  end

  match '/angemeldet' => 'users#signed_up'
  match '/helden' => 'users#index', :as => :users
  match '/helden/:id' => 'users#show', :as => :user
  match '/profil' => 'users#edit', :as => :profile
  match "/users/sign_up" => "home#index"
  match "/users/sign_in" => "home#index"
  devise_for :users, :controllers => { 
    :omniauth_callbacks => "users/omniauth_callbacks",
    :registrations => "users/registrations",
  }

  devise_scope :user do
    match 'abmelden', :to => 'devise/sessions#destroy', :as => 'signout'    
  end
  
  match '/wunschzettel/erstellen' => 'lists#create', :as => :create_list
  match '/wunschzettel/hinzufuegen' => 'lists#add_product_to_list', :as => :add_product_to_list
  match '/wunschzettel/:permalink' => 'lists#show', :as => :list
  match '/wunschzettel' => 'lists#index', :as => :lists

  match "/eigene-geschenkideen" => 'products#own', :as => :own_products
  match "/:slug(/seite-:page)(/:sort)(/preis-:price)" => 'products#index', :as => :product_category

  root :to => "home#index"
end

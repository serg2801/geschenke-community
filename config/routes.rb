App::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  match '/neue-geschenkidee' => 'products#new', :as => :new_product
  match '/geschenkidee/:slug' => 'products#show', :as => :product, :via => :get
  match '/geschenkidee/:slug/bearbeiten' => 'products#edit', :as => :edit_product
  match '/geschenkidee/:slug/neuer-kommentar' => 'products#add_comment', :as => :add_comment_product
  match '/geschenkidee/:slug/loeschen' => 'products#delete', :as => :delete_product
  resources :products, :path => "geschenkidee" do   
    collection do
      post 'find_images', :as => :find_images
    end
  end

  match '/helden' => 'users#index', :as => :users
  match '/helden/:id' => 'users#show', :as => :user
  match '/profil' => 'users#edit', :as => :profile
  devise_for :users, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }

  devise_scope :user do
    match 'abmelden', :to => 'devise/sessions#destroy', :as => 'signout'
  end

  # match 

  # match '/neue-geschenkideen' => 'products#recent', :as => :recent_products
  match "/eigene-geschenkideen" => 'products#own', :as => :own_products
  match "/:slug(/seite-:page)(/:sort)(/preis-:price)" => 'products#index'

  root :to => "products#index"

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id))(.:format)'
end

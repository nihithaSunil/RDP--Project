Rails.application.routes.draw do
  # API routing
  scope module: 'api', defaults: {format: 'json'} do
    namespace :v1 do
      # Routes for API assigment
      get 'orders/baking_list', to: 'orders#baking_list'
      get 'orders/unshipped', to: 'orders#unshipped'
      get 'items/:id', to: 'items#show'
      get 'items/:id/prices', to: 'items#prices'
      get 'customers', to: 'customers#index'
  
      
    end
  end

  # Routes for regular HTML views go here...
    # Semi-static page routes
    get '/',    to: 'home#home',    as: 'home'
    get 'about',   to: 'home#about',   as: 'about'
    get 'contact', to: 'home#contact', as: 'contact'
    get 'privacy', to: 'home#privacy', as: 'privacy'
    get 'error_404', to: 'home#error_404', as: :error_404

    get 'cart',            to: 'cart#view',     as: :view_cart
    get 'cart/add/:id',    to: 'cart#add_item', as: :add_item
    get 'cart/remove/:id', to: 'cart#remove_item', as: :remove_item
    get 'cart/empty',      to: 'cart#empty',    as: :empty_cart
    get 'cart/checkout',   to: 'cart#checkout', as: :checkout



    


    # Authentication routes
    resources :sessions, only: [:new, :create, :destroy]
    resources :addresses
    resources :customers, except: [:destroy]
    resources :employees, except: [:destroy]
    resources :orders
    resources :items
    resources :order_items, only: [:edit, :update, :destroy]
    resources :item_prices, only: [:new, :create]


    






    get 'login', to: 'sessions#new', as: :login
    get 'logout', to: 'sessions#destroy', as: :logout

  
    # Resource routes (maps HTTP verbs to controller actions automatically):
    


    # Cart routes

    



    # Search route(s)

    

    # You can have the root of your site routed with 'root'

    
end

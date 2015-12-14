Rails.application.routes.draw do
  root 'home#index'

  patch 'products/retire/:id' => 'products#retire', as: "retire"

  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'signup' => 'robots#new', :as => 'signup'

  resources :robots do
    resources :orders
    resources :products
  end

  resources :sessions

  patch '/products/:id/add' => 'orderitems#add_to_cart'
  post '/products/:id/add' => 'orderitems#add_to_cart'

  patch 'products/:id/more' => 'orderitems#increase_quantity', as: :more
  patch 'products/:id/less' => 'orderitems#decrease_quantity', as: :less
  delete 'products/:id/remove' => 'orderitems#remove', as: :remove

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  resources :categories, only: [:new, :create]

  get '/products/robots/:id', to: 'products#robot', as: 'by_robot'
  get '/products/categories/:category_name', to: 'products#category', as: 'by_category'

  resources :robots

  get '/orders/checkout' => 'orders#checkout', as: 'checkout'
  patch '/orders/confirm' => 'orders#confirm', as: 'confirm'

  resources :orders

end

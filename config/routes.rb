Rails.application.routes.draw do
  root 'home#index'

  get 'login' => 'sessions#new', :as => 'login'
  get 'logout' => 'sessions#destroy', :as => 'logout'
  get 'signup' => 'robots#new', :as => 'signup'

  resources :robots

  resources :sessions

  patch '/products/:id/add' => 'orderitems#add_to_cart'
  post '/products/:id/add' => 'orderitems#add_to_cart'

  patch 'products/:id/more' => 'orderitems#increase_quantity', as: :more
  patch 'products/:id/less' => 'orderitems#decrease_quantity', as: :less

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  resources :categories, only: [:new, :create]

  get '/products/robots/:robot_name', to: 'products#robot', as: 'by_robot'
  get '/products/categories/:category_name', to: 'products#category', as: 'by_category'
  resources :robots

  resources :orders
end

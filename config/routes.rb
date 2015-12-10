Rails.application.routes.draw do
  root 'home#index'

  patch '/products/:id/add' => 'orderitems#add_to_cart'
  post '/products/:id/add' => 'orderitems#add_to_cart'

  resources :products do
    resources :reviews, only: [:new, :create]
  end

  resources :categories, only: [:new, :create]
  
  get '/products/robots/:robot_name', to: 'products#robot', as: 'by_robot'
  get '/products/categories/:category_name', to: 'products#category', as: 'by_category'
  resources :robots

  resources :orders
end
